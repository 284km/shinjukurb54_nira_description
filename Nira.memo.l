%{
#include <stdio.h>
#include <string.h>
#include "Nira.tab.hh"

extern "C" int yywrap();

int yywrap(void)
{
    return 1;
}

%}
%%

// 規則部 正規表現でトークンを表現しています。
// 規則部は、正規表現の後ろに何個かの空白を入れて、Cのコードを書く、 という形式になっています。 入力された文字列が正規表現にマッチした場合、 その後ろのCのコードが実行されます。 このCコードの部分のことをアクションと呼びます。
// 四則演算の演算子、および改行について、 それぞれ決められたシンボルをreturnしています。 これらのシンボルは、トークンの種類を表現していて、前述のように y.tab.hの中で#defineされています。
// 「トークンの文字列」は、アクションの中では、 yytext で参照することができます
// 色々なトークンの値を格納しなければなりませんから yylval は共用体になっています。その共用体の定義は、yaccの定義ファイル側で行ないます。

"+"        return ADD;
"-"        return SUB;
"*"        return MUL;
"/"        return DIV;
"\n"       return CR;

[1-9][0-9]* {
    int tmp;
    sscanf(yytext, "%d", &tmp);
    yylval.int_value = tmp;
    return INT_LITERAL;
}

%%

// これより後ろは、ユーザコード部になります。 ここには、任意のCのコードを記述することができます(今回は書いてませんが)。 定義部と違い、「%{」[%}」で囲む必要はありません。

