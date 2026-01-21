from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import pymysql
import os  # 新增：读取环境变量，适配GitHub环境

# 初始化Flask应用
app = Flask(__name__)
# 细化CORS配置，适配GitHub跨域
CORS(app, resources={r"/*": {"origins": "*"}})

# ========== 数据库配置（适配GitHub，优先读环境变量） ==========
# 本地运行：用默认值；GitHub运行：通过环境变量传密码/地址
MYSQL_USER = os.getenv('MYSQL_USER', 'root')
MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD', 'SWB123swb')  # 本地默认密码，GitHub用环境变量覆盖
MYSQL_HOST = os.getenv('MYSQL_HOST', 'localhost')
MYSQL_PORT = os.getenv('MYSQL_PORT', 3306)
MYSQL_DB = os.getenv('MYSQL_DB', 'calculator_db')

app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DB}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_POOL_SIZE'] = 5

# 初始化数据库
db = SQLAlchemy(app)

# 定义数据表模型
class CalculationHistory(db.Model):
    __tablename__ = 'calculation_history'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    num1 = db.Column(db.Float, nullable=False)
    num2 = db.Column(db.Float, nullable=False)
    operation = db.Column(db.String(10), nullable=False)
    result = db.Column(db.Float, nullable=False)
    # 修复：datetime.now() 加括号，实时更新时间
    create_time = db.Column(db.DateTime, default=datetime.now)

    def to_dict(self):
        return {
            'id': self.id,
            'num1': self.num1,
            'num2': self.num2,
            'operation': self.operation,
            'result': self.result,
            'create_time': self.create_time.strftime('%Y-%m-%d %H:%M:%S')
        }

# 初始化数据表（适配Flask 2.x+）
with app.app_context():
    db.create_all()

# ========== 数据库操作函数 ==========
def add_calc_history(num1, num2, operation, result):
    try:
        history = CalculationHistory(
            num1=num1,
            num2=num2,
            operation=operation,
            result=result
        )
        db.session.add(history)
        # 修复：seesion → session 拼写错误
        db.session.commit()
        return True
    except Exception as e:
        db.session.rollback()
        print(f"数据库插入失败:{e}")
        return False

def get_calc_history():
    try:
        histories = CalculationHistory.query.order_by(CalculationHistory.create_time.desc()).all()
        return [h.to_dict() for h in histories]
    except Exception as e:
        print(f"数据库查询失败:{e}")
        return []

def clear_calc_history():
    try:
        db.session.query(CalculationHistory).delete()
        db.session.commit()
        return True
    except Exception as e:
        db.session.rollback()
        print(f"清空历史失败：{e}")
        return False

# ========== 计算接口 ==========
@app.route('/calculate', methods=['POST'])
def calculate():
    try:
        data = request.get_json()
        if not data:
            # 新增：返回HTTP状态码，更规范
            return jsonify({"error": "请传递JSON格式的参数"}), 400

        try:
            num1 = float(data.get("num1"))
            num2 = float(data.get("num2"))
            operation = data.get("operation")
        except (TypeError, ValueError):
            return jsonify({"error": "请输入有效的数字"}), 400

        # 修复：运算符号匹配（前端传的是+/-/×/÷/%，验证列表要对应）
        valid_operations = ["+", "-", "×", "÷", "%"]
        if operation not in valid_operations:
            return jsonify({"error": f"无效的运算类型，仅支持：{valid_operations}"}), 400

        result = None
        if operation == "+":
            result = num1 + num2
        elif operation == "-":
            result = num1 - num2
        elif operation == "×":
            result = num1 * num2
        elif operation == "÷":
            if num2 == 0:
                return jsonify({"error": "除数不能为0"}), 400
            result = num1 / num2
        elif operation == "%":
            if num2 == 0:
                return jsonify({"error": "取模的除数不能为0"}), 400
            result = num1 % num2

        # 存入数据库（保留两位小数）
        add_calc_history(num1, num2, operation, round(result, 2))

        # 成功返回（带状态码200）
        return jsonify({
            "result": round(result, 2),
            "num1": num1,
            "num2": num2,
            "operation": operation
        }), 200

    except Exception as e:
        return jsonify({"error": f"计算出错：{str(e)}"}), 500

# ========== 新增：查询历史记录接口（方便测试） ==========
@app.route('/history', methods=['GET'])
def get_history():
    histories = get_calc_history()
    return jsonify({"histories": histories}), 200

# ========== 新增：清空历史记录接口 ==========
@app.route('/history/clear', methods=['DELETE'])
def clear_history():
    success = clear_calc_history()
    if success:
        return jsonify({"message": "历史记录清空成功"}), 200
    else:
        return jsonify({"error": "历史记录清空失败"}), 500

# ========== 运行配置（适配GitHub） ==========
if __name__ == "__main__":
    # GitHub运行时端口可能需要用环境变量（避免端口冲突）
    port = int(os.getenv('PORT', 5000))
    app.run(host="0.0.0.0", port=port, debug=False)  # GitHub上关闭debug模式（安全）
