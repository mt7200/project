"""Excel 数据导入工具脚本

用法:
    python -m scripts.import_excel --file path/to/data.xlsx
"""
import argparse
import os
import sys


def main():
    parser = argparse.ArgumentParser(description="导入 Excel 数据到数据库")
    parser.add_argument("--file", required=True, help="Excel 文件路径")
    parser.add_argument("--type", choices=["herb", "formula", "patient"], default="herb", help="数据类型")
    args = parser.parse_args()

    if not os.path.exists(args.file):
        print(f"文件不存在: {args.file}", file=sys.stderr)
        sys.exit(1)

    # TODO: 使用 openpyxl 读取并批量写入数据库
    print(f"TODO: 导入 {args.type} 数据 from {args.file}")


if __name__ == "__main__":
    main()
