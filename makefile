# MAKE_O = gcc -c $<
# .oのところに使っていたけど勝手に
# cc    -c -o hoge.o hoge.c をやってくれるので要らない
LDLIBS := -lncurses
# 勝手にncursesのリンクをするのでいままでの gcc -lncurses -o $@ $^　は不要
TARGET = sudokuSolve #実行ファイル
VPATH = source #ソースが入っているディレクトリ
OBJS = main.o calc.o fileio.o menu.o setting.o

all: ${TARGET}

${TARGET}: ${OBJS}
	${CC} -o $@ ${OBJS} ${LDLIBS}

main.o:
# main.cを使うのは明らかなので書かなくて良い
# インクルードファイルは書いてあげる
calc.o: calc.h
fileio.o: fileio.h calc.h
menu.o: menu.h calc.h setting.h fileio.h
setting.o: setting.h

.PHONY: dir compile do clean git

compile:
	@make -s all
	@make -s clean
	@printf "\
	=============\n\
	compile end!!\n\
	$$ make do\n\
	to start\n\
	=============\n"
# @[コマンド]は標準出力に表示しない

do: 
	@./${TARGET}

clean: 
	rm ${OBJS}

# log.cコンパイル
log: log.o calc.o fileio.o menu.o setting.o
	-mkdir -p logdata
	${CC} -o $@ $^ ${LDLIBS}
	@rm ${OBJS} log.o