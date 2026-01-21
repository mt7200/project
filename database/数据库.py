from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
import pymysql
app=Flask(__name__)
CORS(app)

MYSQL_PASSWORD="SWB123swb"
app.config['SQLALCHEMY_DATABASE_URI']=f'mysql+pymysql://root:{MYSQL_PASSWORD}@localhost:3306/calculator_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_POOL_SIZE'] = 5

db=SQLAlchemy(app)
class CalculationHistory(db.Model):
    __tablename__='calculation_history'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    num1 = db.Column(db.Float, nullable=False)
    num2 = db.Column(db.Float, nullable=False)
    operation = db.Column(db.String(10), nullable=False)
    result = db.Column(db.Float, nullable=False)
    create_time = db.Column(db.DateTime, default=datetime.now)
    def to_dict(self):
        return{
            'id': self.id,
            'num1': self.num1,
            'num2': self.num2,
            'operation': self.operation,
            'result': self.result,
            'create_time': self.create_time.strftime('%Y-%m-%d %H:%M:%S')
        }
with app.app_context():
    db.create_all()


def add_calc_history(num1, num2, operation, result):
    try:
        history=CalculationHistory(
            num1=num1,
            num2=num2,
            operation=operation,
            result=result
        )
        db.session.add(history)
        db.seesion.commit()
        return True
    except Exception as e :
        db.session.rollback()
        print(f"数据库插入失败:{e}")
        return False
def get_calc_history():
    try:
        histories=CalculationHistory.query.order_by(CalculationHistory.create_time.desc()).all()
        return [h.to_dict() for h in histories]
    except Exception as e :
        print(f"数据库查询失败:{e}")
        return []
def clear_calc_history():
    try :
        db.session.query(CalculationHistory).delete()
        db.session.commit()
        return True
    except Exception as e:
        db.session.rollback()
        print(f"清空历史失败：{e}")
        return False


@app.route('/calculate', methods=['POST'])
def calculate():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "请传递JSON格式的参数"})

        try:
            num1 = float(data.get("num1"))
            num2 = float(data.get("num2"))
            operation = data.get("operation")
        except (TypeError, ValueError):
            return jsonify({"error": "请输入有效的数字"})


        valid_operations = ["add", "sub", "mul", "div", "mod"]
        if operation not in valid_operations:
            return jsonify({"error": f"无效的运算类型，仅支持：{valid_operations}"})


        result = None
        if operation == "+":
            result = num1 + num2
        elif operation == "-":
            result = num1 - num2
        elif operation == "×":
            result = num1 * num2
        elif operation == "÷":
            if num2 == 0:
                return jsonify({"error": "除数不能为0"})
            result = num1 / num2
        elif operation == "%":
            if num2 == 0:
                return jsonify({"error": "取模的除数不能为0"})
            result = num1 % num2
        # 4. 存入数据库（你的核心逻辑）
        add_calc_history(num1, num2, operation, round(result, 2))

        # 5. 成功：返回约定字段
        return jsonify({
            "result": round(result, 2),
            "num1": num1,
            "num2": num2,
            "operation": operation
        })


    except Exception as e:
        return jsonify({"error": f"计算出错：{str(e)}"})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
