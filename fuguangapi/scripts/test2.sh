#!/bin/bash
# 注释，后续的代码必须要符合shell的语法，或者可以填写Linux命令，例如: chmod,cd ,copy

# 接收终端参数
# $1 表示命令文件后的第1个参数
# $2 表示命令文件后的第2个参数
# ...
# $n 表示命令文件后的第n个参数

# 在shell中，往往接收参数以后都会声明一个大写的变量名，保存参数的值
COMMAND=$1
# shell调用参数时，都是需要基于$开头写上变量名的
echo "$COMMAND"
# 判断
if [ "$COMMAND" == "manage" ]; then
    echo "运行项目"
# 在创建demo目录，并在目录下创建0-9html文件，写入hello内容
elif [ "$COMMAND" == "10" ]; then
  mkdir -p "demo"
  for (( i = 0; i < "$COMMAND"; i++ )); do
        echo "hello" > "./demo/$i.html"
  done
fi

# touch "./demo/$i.html"
# ./test2.sh manage
# ./test2.sh 10