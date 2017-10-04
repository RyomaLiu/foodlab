##脚本实现
在target中添加run script
>python ${SRCROOT}/${TARGET_NAME}/Script/AutoGenStrings.py ${SRCROOT}/${TARGET_NAME}

##手动实现
定位到storyboard所在目录
>ibtool Main.storyboard --generate-strings-file ./NewTemp.string


##从代码中搜集
代码中需要用这个：NSLocalizedString(@"使用帮助", nil)

//建成文件夹
mkdir zh-Hans.lproj
mkdir en.lproj

//生成strings文件
genstrings -o zh-Hans.lproj *.m
genstrings -o en.lproj *.m

//会递归生成
find ./ -name *.m | xargs genstrings -o en.lproj
