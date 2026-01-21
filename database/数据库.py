from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import os

# 初始化Flask应用
app = Flask(__name__)
# 跨域配置（适配前端）
CORS(app, resources={r"/*": {"origins": "*"}})

# ========== SQLite配置（核心！零依赖，无需MySQL） ==========
# 数据库文件存放在项目目录下的calc_history.db，无需启动服务
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///calc_history.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# 初始化数据库
db = SQLAlchemy(app)

# 定义数据表模型（和原有逻辑一致）
class CalculationHistory(db.Model):
    __tablename__ = 'calculation_history'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    num1 = db.Column(db.Float, nullable=False)
    num2 = db.Column(db.Float, nullable=False)
    operation = db.Column(db.String(10), nullable=False)
    result = db.Column(db.Float, nullable=False)
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
    db.create_all()  # 自动创建calc_history.db文件，无需手动建库

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
        db.session.commit()
        return True
    except Exception as e:
        db.session.rollback()
        print(f"插入失败:{e}")
        return False

def get_calc_history():
    try:
        histories = CalculationHistory.query.order_by(CalculationHistory.create_time.desc()).all()
        return [h.to_dict() for h in histories]
    except Exception as e:
        print(f"查询失败:{e}")
        return []

def clear_calc_history():
    try:
        db.session.query(CalculationHistory).delete()
        db.session.commit()
        return True
    except Exception as e:
        db.session.rollback()
        print(f"清空失败：{e}")
        return False

# ========== 计算接口（和原有逻辑一致） ==========
@app.route('/calculate', methods=['POST'])
def calculate():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "请传递JSON参数"}), 400

        try:
            num1 = float(data.get("num1"))
            num2 = float(data.get("num2"))
            operation = data.get("operation")
        except (TypeError, ValueError):
            return jsonify({"error": "请输入有效数字"}), 400

        # 适配前端常见的运算符号
        valid_operations = ["+", "-", "×", "÷", "%", "add", "subtract", "multiply", "divide", "modulus"]
        if operation not in valid_operations:
            return jsonify({"error": f"仅支持：{valid_operations}"}), 400

        # 统一运算逻辑（兼容符号/英文）
        result = None
        if operation in ["+", "add"]:
            result = num1 + num2
        elif operation in ["-", "subtract"]:
            result = num1 - num2
        elif operation in ["×", "multiply"]:
            result = num1 * num2
        elif operation in ["÷", "divide"]:
            if num2 == 0:
                return jsonify({"error": "除数不能为0"}), 400
            result = num1 / num2
        elif operation in ["%", "modulus"]:
            if num2 == 0:
                return jsonify({"error": "取模除数不能为0"}), 400
            result = num1 % num2

        # 存入数据库（保留两位小数）
        add_calc_history(num1, num2, operation, round(result, 2))

        return jsonify({
            "result": round(result, 2),
            "num1": num1,
            "num2": num2,
            "operation": operation
        }), 200

    except Exception as e:
        return jsonify({"error": f"计算出错：{str(e)}"}), 500

# ========== 历史记录接口 ==========
@app.route('/history', methods=['GET'])
def get_history():
    histories = get_calc_history()
    return jsonify({"histories": histories}), 200

@app.route('/history/clear', methods=['DELETE'])
def clear_history():
    success = clear_calc_history()
    if success:
        return jsonify({"message": "历史记录清空成功"}), 200
    else:
        return jsonify({"error": "清空失败"}), 500

# ========== 运行配置 ==========
if __name__ == "__main__":
    port = int(os.getenv('PORT', 5000))
    app.run(host="0.0.0.0", port=port, debug=True)  # debug=True方便调试
