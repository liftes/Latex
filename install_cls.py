import os
import shutil
import subprocess

TEXMFHOME = r"C:\Users\79323\texmf\tex\latex"
current_dir = os.path.dirname(os.path.abspath(__file__))
os.makedirs(TEXMFHOME, exist_ok=True)

cls_files = [f for f in os.listdir(current_dir) if f.endswith(".cls")]
if not cls_files:
    print("未找到任何 .cls 文件。")
    exit()

print("发现以下 cls 文件：")
for f in cls_files:
    print(" -", f)

for cls in cls_files:
    cls_name = os.path.splitext(cls)[0]
    target_dir = os.path.join(TEXMFHOME, cls_name)

    # —— 清空旧版本，避免残留 —— 
    if os.path.exists(target_dir):
        shutil.rmtree(target_dir)
    os.makedirs(target_dir)

    src = os.path.join(current_dir, cls)
    dst = os.path.join(target_dir, cls)
    shutil.copy2(src, dst)

    print(f"已安装 {cls} → {target_dir}")

# 刷新数据库
print("\n正在刷新 TeX Live 文件数据库……")
subprocess.run("mktexlsr", shell=True)

# 检查最终实际使用的路径
print("\n检查 TeX 实际加载的文档类路径：")
for cls in cls_files:
    result = subprocess.run(
        ["kpsewhich", cls],
        capture_output=True,
        text=True
    )
    print(f"{cls} → {result.stdout.strip()}")

print("\n安装完成！")
