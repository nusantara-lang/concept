/*
 *
 * Grammar untuk bahasa pemrograman Nusantara
 *
 * ----------------------------------------------------------------------------
 * Project: Nusantara
 * Author: Fern Aerell
 * License: BSD 3-Clause License
 * Copyright (c) 2025, The Nusantara Project authors.
 * ----------------------------------------------------------------------------
 */

grammar Nusantara;

options {
    language = Cpp; // Bahasa target untuk generator parser dan lexer
}

/* Lexer */

// Mengabaikan whitespace
WS: [ \t\r\n]+ -> skip;

// Menangani komentar satu baris
LINE_COMMENT: '//' ~[\r\n]* -> skip;
// Menangani komentar blok
BLOCK_COMMENT: '/*' .*? '*/' -> skip;

// Mendefinisikan tanda kurung dan kurung kurawal
PAREN_OPEN: '('; // Kurung bulat buka
PAREN_CLOSE: ')'; // Kurung bulat tutup

// Mendefinisikan kata kunci dalam bahasa Nusantara
KW_MUAT: 'muat'; // Kata kunci untuk memuat file

// Literals yang didukung dalam bahasa Nusantara
LIT_BUL: [0-9]+; // Literal bilangan bulat (integer)
LIT_TEKS: '"' ~'"'* '"'; // Literal teks (string)

// Token tambahan yang diperlukan
IDENTIFIER: [a-zA-Z_][a-zA-Z0-9_]*; // Identifier

/* Parser */

// Inisialisasi
nusantara: loadFile* expression* EOF
         ;

loadFile: KW_MUAT LIT_TEKS
        ;

// Expressions
expression: primaryExpression
          ;

primaryExpression: LIT_BUL
                 | LIT_TEKS
                 | callFunction
                 ;

callFunction: IDENTIFIER PAREN_OPEN functionArguments? PAREN_CLOSE;

functionArguments: expression
                 ;