#!/usr/bin/env python3

import sys
import chess
import os

LATEX_WRAPPER ="""
\\documentclass{{article}}
\\nonstopmode
\\usepackage{{xskak}}
\\usepackage[a4paper,
            left=1cm,
            right=1cm,
            top=1cm,
            bottom=1cm]{{geometry}}
\\pagestyle{{empty}}

\\begin{{document}}
{}
\\end{{document}}
"""

BOARD_LATEX = "\\chessboard[setfen={},showmover=false,labelleft=false,labelbottom=false,showmover=true]\n"

def get_arg(argv):
    if len(argv) == 0: return None, None
    arg, *rest = argv
    return arg, rest

def check_fen(fen):
    try:
        chess.Board(fen)
        return True
    except Exception as e:
        print(f"{fen} is not valid FEN! Reason: {e}")
        print("Skipping...")
        return False

def create_pdf(fens):
    board_strings = list(map(lambda x: BOARD_LATEX.format(x), filter(check_fen, fens)))
    latex_boards = ""
    for idx, board_string in enumerate(board_strings):
        print(board_string)
        latex_boards += board_string
        if idx % 2 == 1 and idx != 0:
            latex_boards += "\\linebreak\n"
    
    latex = LATEX_WRAPPER.format(latex_boards)
    print(latex)

    with open("fen.tex", "w") as f:
        f.write(latex)
    
    os.system("pdflatex fen.tex &> /dev/null")
    os.system("latexmk -c &> /dev/null")
    os.system("rm -rf fen.tex &> /dev/null")

def load_from_file(argv):
    file_name, _ = get_arg(argv)
    
    if file_name == "None":
        print("Usage: board-viz f <file-name>")
        exit(-1)
    
    with open(file_name, "r") as f:
        fens = [line.strip() for line in f]

    create_pdf(fens)

def load_inline(argv):
    fens = []
    arg, argv = get_arg(argv)
    while arg != None:
        fens.append(arg.strip())
        arg, argv = get_arg(argv)

    create_pdf(fens)

def main():
    program, argv = get_arg(sys.argv)
    subcommand, argv = get_arg(argv)
    
    if subcommand == None:
        print("Usage: board-viz <subcommand> args...")
        print("""Subcommands:
              \tf: load board representation from file
              \ti: inline board representation in args
              """)
        exit(-1)

    if subcommand == "f":
        load_from_file(argv)
    elif subcommand == "i":
        load_inline(argv)
    else:
        print(f"Unknown subcommand {subcommand}")

if __name__ == "__main__":
    main()
