# 自动安装 LaTeX `.cls` 文档类的脚本

该脚本用于将当前目录内的所有 `.cls` 文件自动安装到用户的 `TEXMFHOME`，并执行 `mktexlsr` 刷新数据库，使文档类可立即被 LaTeX 调用。

---

## 功能

* 扫描当前目录下的全部 `.cls` 文件
* 为每个文档类创建独立文件夹
* 自动复制至

  ```
  C:\Users\<用户名>\texmf\tex\latex\<cls_name>\
  ```
* 执行 `mktexlsr` 刷新文件数据库
* 自动覆盖旧版本（使用前先清空旧目录）

---

## 使用方法

1. 将脚本放到含有 `.cls` 文件的目录

2. 运行：

   ```bash
   python install_cls.py
   ```

3. 运行完成后即可在 LaTeX 中使用：

   ```latex
   \documentclass{MyClass}
   ```

---

## 覆盖旧版本

脚本在安装前会删除旧目录，确保不会遗留旧 `.cls`。
执行完成后，脚本会通过 `kpsewhich` 显示 LaTeX 实际加载的文档类路径，确认是否正确生效。

---

## 适用场景

* 个人文档类快速安装
* 多模板管理
* 避免手动复制和冲突问题

