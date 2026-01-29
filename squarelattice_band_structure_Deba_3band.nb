(* Content-type: application/vnd.wolfram.mathematica *)

(*** Wolfram Notebook File ***)
(* http://www.wolfram.com/nb *)

(* CreatedBy='Wolfram 14.2' *)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[       154,          7]
NotebookDataLength[    882166,      20633]
NotebookOptionsPosition[    880075,      20595]
NotebookOutlinePosition[    880469,      20611]
CellTagsIndexPosition[    880426,      20608]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"ClearAll", "[", 
    RowBox[{
    "kx", ",", "ky", ",", "k", ",", "processHijNew", ",", 
     "trigExpansionRulesFull", ",", "separateExpFactors", ",", 
     "simplifyExpArgs", ",", "getExpKxPower", ",", "filterByExponent", ",", 
     "processMatrixEntry", ",", "Hraw2", ",", "Hfinal2"}], "]"}], ";"}], 
  "\[IndentingNewLine]", "\[IndentingNewLine]", 
  RowBox[{"(*", 
   RowBox[{
    RowBox[{
     RowBox[{"Step", " ", "1"}], ":", 
     RowBox[{
      RowBox[{"Define", " ", "k"}], "-", "vector"}]}], ",", "  ", 
    RowBox[{
    "this", " ", "has", " ", "to", " ", "be", " ", "modified", " ", "in", " ",
      "different", " ", "lattices"}], " ", ",", " ", 
    RowBox[{
    "here", " ", "it", " ", "is", " ", "a", " ", "square", " ", "lattice"}]}],
    "*)"}]}], "\n", 
 RowBox[{
  RowBox[{
   RowBox[{"k", "=", 
    RowBox[{
     RowBox[{"kx", " ", 
      RowBox[{"{", 
       RowBox[{"1", ",", "0"}], "}"}]}], "+", 
     RowBox[{"ky", " ", 
      RowBox[{"{", 
       RowBox[{"0", ",", "1"}], "}"}]}]}]}], ";"}], "\n", 
  "\[IndentingNewLine]", 
  RowBox[{"(*", 
   RowBox[{
    RowBox[{"Trig", " ", "expansion", " ", "rules"}], "  ", ",", " ", 
    RowBox[{"expands", " ", "all", " ", 
     RowBox[{"cos", "^", "2"}], " ", "and", " ", 
     RowBox[{"sin", "^", "2"}], " ", "terms"}]}], "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"trigExpansionRulesFull", "=", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       RowBox[{
        RowBox[{"Cos", "[", "arg_", "]"}], "^", "2"}], ":>", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"1", "+", 
          RowBox[{"Cos", "[", 
           RowBox[{"2", " ", "arg"}], "]"}]}], ")"}], "/", "2"}]}], ",", 
      RowBox[{
       RowBox[{
        RowBox[{"Sin", "[", "arg_", "]"}], "^", "2"}], ":>", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"1", "-", 
          RowBox[{"Cos", "[", 
           RowBox[{"2", " ", "arg"}], "]"}]}], ")"}], "/", "2"}]}], ",", 
      RowBox[{
       RowBox[{
        RowBox[{"Cos", "[", "arg_", "]"}], "^", "3"}], ":>", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{
          RowBox[{"3", " ", 
           RowBox[{"Cos", "[", "arg", "]"}]}], "+", 
          RowBox[{"Cos", "[", 
           RowBox[{"3", " ", "arg"}], "]"}]}], ")"}], "/", "4"}]}], ",", 
      RowBox[{
       RowBox[{
        RowBox[{"Cos", "[", "a_", "]"}], " ", 
        RowBox[{"Cos", "[", "b_", "]"}]}], ":>", 
       RowBox[{
        RowBox[{"1", "/", "2"}], " ", 
        RowBox[{"(", 
         RowBox[{
          RowBox[{"Cos", "[", 
           RowBox[{"a", "+", "b"}], "]"}], "+", 
          RowBox[{"Cos", "[", 
           RowBox[{"a", "-", "b"}], "]"}]}], ")"}]}]}], ",", 
      RowBox[{
       RowBox[{
        RowBox[{"Sin", "[", "a_", "]"}], " ", 
        RowBox[{"Sin", "[", "b_", "]"}]}], ":>", 
       RowBox[{
        RowBox[{"1", "/", "2"}], " ", 
        RowBox[{"(", 
         RowBox[{
          RowBox[{"Cos", "[", 
           RowBox[{"a", "-", "b"}], "]"}], "-", 
          RowBox[{"Cos", "[", 
           RowBox[{"a", "+", "b"}], "]"}]}], ")"}]}]}], ",", 
      RowBox[{
       RowBox[{
        RowBox[{"Sin", "[", "a_", "]"}], " ", 
        RowBox[{"Cos", "[", "b_", "]"}]}], ":>", 
       RowBox[{
        RowBox[{"1", "/", "2"}], " ", 
        RowBox[{"(", 
         RowBox[{
          RowBox[{"Sin", "[", 
           RowBox[{"a", "+", "b"}], "]"}], "+", 
          RowBox[{"Sin", "[", 
           RowBox[{"a", "-", "b"}], "]"}]}], ")"}]}]}], ",", 
      RowBox[{
       RowBox[{
        RowBox[{"Cos", "[", "a_", "]"}], " ", 
        RowBox[{"Sin", "[", "b_", "]"}]}], ":>", 
       RowBox[{
        RowBox[{"1", "/", "2"}], " ", 
        RowBox[{"(", 
         RowBox[{
          RowBox[{"Sin", "[", 
           RowBox[{"a", "+", "b"}], "]"}], "-", 
          RowBox[{"Sin", "[", 
           RowBox[{"a", "-", "b"}], "]"}]}], ")"}]}]}]}], "}"}]}], ";"}], 
  "\n", "\[IndentingNewLine]", 
  RowBox[{"(*", 
   RowBox[{"Trig", " ", "to", " ", "exponential", " ", "form"}], "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"cosToExp", "=", 
   RowBox[{
    RowBox[{"Cos", "[", "arg_", "]"}], ":>", 
    RowBox[{
     RowBox[{"1", "/", "2"}], " ", 
     RowBox[{"(", 
      RowBox[{
       RowBox[{"Exp", "[", 
        RowBox[{"I", " ", "arg"}], "]"}], "+", 
       RowBox[{"Exp", "[", 
        RowBox[{
         RowBox[{"-", "I"}], " ", "arg"}], "]"}]}], ")"}]}]}]}], ";"}], "\n", 

 RowBox[{
  RowBox[{
   RowBox[{"sinToExp", "=", 
    RowBox[{
     RowBox[{"Sin", "[", "arg_", "]"}], ":>", 
     RowBox[{
      RowBox[{"1", "/", 
       RowBox[{"(", 
        RowBox[{"2", " ", "I"}], ")"}]}], " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"Exp", "[", 
         RowBox[{"I", " ", "arg"}], "]"}], "-", 
        RowBox[{"Exp", "[", 
         RowBox[{
          RowBox[{"-", "I"}], " ", "arg"}], "]"}]}], ")"}]}]}]}], ";"}], 
  "\[IndentingNewLine]", "\n", 
  RowBox[{"(*", 
   RowBox[{
   "Separate", " ", "exp", " ", "factors", " ", "involving", " ", "kx", " ", 
    "and", " ", "ky"}], "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"separateExpFactors", "[", "expr_", "]"}], ":=", 
    RowBox[{"expr", "//.", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{
        RowBox[{"Exp", "[", 
         RowBox[{"I", " ", 
          RowBox[{"(", 
           RowBox[{
            RowBox[{"a_.", " ", "kx"}], "+", 
            RowBox[{"b_.", " ", "ky"}]}], ")"}]}], "]"}], ":>", 
        RowBox[{
         RowBox[{"Exp", "[", 
          RowBox[{"I", " ", "a", " ", "kx"}], "]"}], " ", 
         RowBox[{"Exp", "[", 
          RowBox[{"I", " ", "b", " ", "ky"}], "]"}]}]}], ",", 
       RowBox[{
        RowBox[{"Exp", "[", 
         RowBox[{"I", " ", 
          RowBox[{"(", 
           RowBox[{
            RowBox[{"a_.", " ", "ky"}], "+", 
            RowBox[{"b_.", " ", "kx"}]}], ")"}]}], "]"}], ":>", 
        RowBox[{
         RowBox[{"Exp", "[", 
          RowBox[{"I", " ", "b", " ", "kx"}], "]"}], " ", 
         RowBox[{"Exp", "[", 
          RowBox[{"I", " ", "a", " ", "ky"}], "]"}]}]}], ",", 
       RowBox[{
        RowBox[{"Exp", "[", 
         RowBox[{"I", " ", 
          RowBox[{"(", 
           RowBox[{"a_.", " ", "kx"}], ")"}]}], "]"}], ":>", 
        RowBox[{"Exp", "[", 
         RowBox[{"I", " ", "a", " ", "kx"}], "]"}]}], ",", 
       RowBox[{
        RowBox[{"Exp", "[", 
         RowBox[{"I", " ", 
          RowBox[{"(", 
           RowBox[{"a_.", " ", "ky"}], ")"}]}], "]"}], ":>", 
        RowBox[{"Exp", "[", 
         RowBox[{"I", " ", "a", " ", "ky"}], "]"}]}]}], "}"}]}]}], ";"}], 
  "\[IndentingNewLine]", "\n", 
  RowBox[{"(*", 
   RowBox[{
    RowBox[{
    "New", " ", "function", " ", "to", " ", "simplify", " ", "exponents", " ",
      "in", " ", "the", " ", "form", " ", "a", " ", "kx"}], "+", 
    RowBox[{"b", " ", "ky"}]}], "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"simplifyExpArgs", "[", "expr_", "]"}], ":=", 
    RowBox[{"expr", "/.", " ", 
     RowBox[{
      RowBox[{"Exp", "[", "arg_", "]"}], ":>", 
      RowBox[{"Exp", "[", 
       RowBox[{"Expand", "[", "arg", "]"}], "]"}]}]}]}], ";"}], "\n", 
  "\[IndentingNewLine]", 
  RowBox[{"(*", 
   RowBox[{
    RowBox[{"Full", " ", "pre"}], "-", 
    RowBox[{
    "processing", " ", "of", " ", "the", " ", "Hamiltonian", " ", "matrix", " ",
      "elements", " ", "using", " ", "previously", " ", "defined", " ", 
     "functions"}]}], "  ", "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"processHijNew", "[", "expr_", "]"}], ":=", 
    RowBox[{"Module", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"step1", ",", "step2", ",", "step3"}], "}"}], ",", 
      RowBox[{
       RowBox[{"step1", "=", 
        RowBox[{
         RowBox[{"expr", "/.", " ", "trigExpansionRulesFull"}], "//", 
         "Expand"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"step2", "=", 
        RowBox[{
         RowBox[{
          RowBox[{"step1", "/.", " ", 
           RowBox[{"{", 
            RowBox[{"cosToExp", ",", "sinToExp"}], "}"}]}], "//", "Expand"}], 
         "//", "Simplify"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"step3", "=", 
        RowBox[{
         RowBox[{"separateExpFactors", "[", "step2", "]"}], "//", 
         "Expand"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"simplifyExpArgs", "[", "step3", "]"}]}]}], "]"}]}], ";"}], 
  "\n", "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"Hraw2", "=", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
        RowBox[{
         RowBox[{"-", "2"}], "+", "\[Delta]", "+", 
         RowBox[{
          RowBox[{"Sin", "[", 
           RowBox[{"Pi", " ", "kx"}], "]"}], "^", "2"}]}], ",", 
        RowBox[{
         RowBox[{"Sin", "[", 
          RowBox[{"Pi", " ", "kx"}], "]"}], " ", 
         RowBox[{"Sin", "[", 
          RowBox[{"Pi", " ", "ky"}], "]"}]}], ",", 
        RowBox[{
         RowBox[{"(", 
          RowBox[{"m", "-", 
           RowBox[{"t1", " ", 
            RowBox[{"(", 
             RowBox[{
              RowBox[{"Cos", "[", 
               RowBox[{"Pi", " ", "kx"}], "]"}], "+", 
              RowBox[{"Cos", "[", 
               RowBox[{"Pi", " ", "ky"}], "]"}]}], ")"}]}], "-", 
           RowBox[{"t2", " ", 
            RowBox[{"Cos", "[", 
             RowBox[{"Pi", " ", 
              RowBox[{"(", 
               RowBox[{"kx", "+", "ky"}], ")"}]}], "]"}]}]}], ")"}], " ", 
         RowBox[{"Sin", "[", 
          RowBox[{"Pi", " ", "kx"}], "]"}]}]}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{
         RowBox[{"Sin", "[", 
          RowBox[{"Pi", " ", "kx"}], "]"}], " ", 
         RowBox[{"Sin", "[", 
          RowBox[{"Pi", " ", "ky"}], "]"}]}], ",", 
        RowBox[{
         RowBox[{"-", "2"}], "-", "\[Delta]", "+", 
         RowBox[{
          RowBox[{"Sin", "[", 
           RowBox[{"Pi", " ", "ky"}], "]"}], "^", "2"}]}], ",", 
        RowBox[{
         RowBox[{"(", 
          RowBox[{"m", "-", 
           RowBox[{"t1", " ", 
            RowBox[{"(", 
             RowBox[{
              RowBox[{"Cos", "[", 
               RowBox[{"Pi", " ", "kx"}], "]"}], "+", 
              RowBox[{"Cos", "[", 
               RowBox[{"Pi", " ", "ky"}], "]"}]}], ")"}]}], "-", 
           RowBox[{"t2", " ", 
            RowBox[{"Cos", "[", 
             RowBox[{"Pi", " ", 
              RowBox[{"(", 
               RowBox[{"kx", "+", "ky"}], ")"}]}], "]"}]}]}], ")"}], " ", 
         RowBox[{"Sin", "[", 
          RowBox[{"Pi", " ", "ky"}], "]"}]}]}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{
        RowBox[{
         RowBox[{"(", 
          RowBox[{"m", "-", 
           RowBox[{"t1", " ", 
            RowBox[{"(", 
             RowBox[{
              RowBox[{"Cos", "[", 
               RowBox[{"Pi", " ", "kx"}], "]"}], "+", 
              RowBox[{"Cos", "[", 
               RowBox[{"Pi", " ", "ky"}], "]"}]}], ")"}]}], "-", 
           RowBox[{"t2", " ", 
            RowBox[{"Cos", "[", 
             RowBox[{"Pi", " ", 
              RowBox[{"(", 
               RowBox[{"kx", "+", "ky"}], ")"}]}], "]"}]}]}], ")"}], " ", 
         RowBox[{"Sin", "[", 
          RowBox[{"Pi", " ", "kx"}], "]"}]}], ",", 
        RowBox[{
         RowBox[{"(", 
          RowBox[{"m", "-", 
           RowBox[{"t1", " ", 
            RowBox[{"(", 
             RowBox[{
              RowBox[{"Cos", "[", 
               RowBox[{"Pi", " ", "kx"}], "]"}], "+", 
              RowBox[{"Cos", "[", 
               RowBox[{"Pi", " ", "ky"}], "]"}]}], ")"}]}], "-", 
           RowBox[{"t2", " ", 
            RowBox[{"Cos", "[", 
             RowBox[{"Pi", " ", 
              RowBox[{"(", 
               RowBox[{"kx", "+", "ky"}], ")"}]}], "]"}]}]}], ")"}], " ", 
         RowBox[{"Sin", "[", 
          RowBox[{"Pi", " ", "ky"}], "]"}]}], ",", 
        RowBox[{
         RowBox[{"-", "2"}], "+", 
         RowBox[{
          RowBox[{"(", 
           RowBox[{
            RowBox[{"-", "m"}], "+", 
            RowBox[{"t1", " ", 
             RowBox[{"(", 
              RowBox[{
               RowBox[{"Cos", "[", 
                RowBox[{"Pi", " ", "kx"}], "]"}], "+", 
               RowBox[{"Cos", "[", 
                RowBox[{"Pi", " ", "ky"}], "]"}]}], ")"}]}], "+", 
            RowBox[{"t2", " ", 
             RowBox[{"Cos", "[", 
              RowBox[{"Pi", " ", 
               RowBox[{"(", 
                RowBox[{"kx", "+", "ky"}], ")"}]}], "]"}]}]}], ")"}], "^", 
          "2"}]}]}], "}"}]}], "}"}]}], ";"}], "\[IndentingNewLine]", "\n", 
  RowBox[{"(*", 
   RowBox[{"Expand", " ", "Hamiltonian"}], "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"Hfinal2", "=", 
   RowBox[{"Map", "[", 
    RowBox[{"processHijNew", ",", "Hraw2", ",", 
     RowBox[{"{", "2", "}"}]}], "]"}]}], ";"}], "\n", 
 RowBox[{"MatrixForm", "[", "Hfinal2", "]"}]}], "Input",
 CellChangeTimes->{
  3.978313294093803*^9, {3.978319320084803*^9, 3.978319324675007*^9}, {
   3.978319522062038*^9, 3.978319613856949*^9}, {3.97831974811975*^9, 
   3.97831974814598*^9}, {3.978319862897561*^9, 3.978319896532564*^9}, 
   3.978325229527918*^9},
 CellLabel->"In[10]:=",ExpressionUUID->"1c5d6259-97a0-4c75-abb3-e912dd23b2b4"],

Cell[BoxData[
 TagBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {
      RowBox[{
       RowBox[{"-", 
        FractionBox["3", "2"]}], "-", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "kx", " ", 
          "\[Pi]"}]]}], "-", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"2", " ", "\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}]]}]}], 
      RowBox[{
       RowBox[{
        RowBox[{"-", 
         FractionBox["1", "4"]}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "-", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}]}], 
      RowBox[{
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "kx", " ", 
          "\[Pi]"}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"2", " ", "\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}]}]},
     {
      RowBox[{
       RowBox[{
        RowBox[{"-", 
         FractionBox["1", "4"]}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "-", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}]}], 
      RowBox[{
       RowBox[{"-", 
        FractionBox["3", "2"]}], "-", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "ky", " ", 
          "\[Pi]"}]]}], "-", 
       RowBox[{
        FractionBox["1", "4"], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"2", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}], 
      RowBox[{
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "ky", " ", 
          "\[Pi]"}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"2", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}]}]},
     {
      RowBox[{
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "kx", " ", 
          "\[Pi]"}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"2", " ", "\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}]}], 
      RowBox[{
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "ky", " ", 
          "\[Pi]"}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"2", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "-", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{
        RowBox[{"(", 
         RowBox[{"0.`", "\[VeryThinSpace]", "+", 
          RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}]}], 
      RowBox[{
       RowBox[{
        RowBox[{"-", "1.`"}], " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}]]}], "-", 
       RowBox[{"1.`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}]]}], "+", 
       RowBox[{"0.25`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "kx", " ", 
          "\[Pi]"}]]}], "+", 
       RowBox[{"0.25`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"2", " ", "\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}]]}], "-", 
       RowBox[{"1.`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "-", 
       RowBox[{"1.`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "+", 
       RowBox[{"0.25`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "ky", " ", 
          "\[Pi]"}]]}], "+", 
       RowBox[{"0.25`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"2", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "+", 
       RowBox[{"0.5`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{"0.5`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "-", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{"0.5`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{
           RowBox[{"-", "\[ImaginaryI]"}], " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}], "+", 
       RowBox[{"0.5`", " ", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{
          RowBox[{"\[ImaginaryI]", " ", "kx", " ", "\[Pi]"}], "+", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]}]]}]}]}
    },
    GridBoxAlignment->{"Columns" -> {{Center}}, "Rows" -> {{Baseline}}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}}], "\[NoBreak]", ")"}],
  Function[BoxForm`e$, 
   MatrixForm[BoxForm`e$]]]], "Output",
 CellChangeTimes->{3.9783140273215523`*^9, 3.978314495357098*^9, 
  3.9783148942532587`*^9, 3.978324951015753*^9, 3.9783252326515493`*^9, 
  3.978325265100992*^9, 3.9783256098169327`*^9, 3.978329412440292*^9},
 CellLabel->
  "Out[20]//MatrixForm=",ExpressionUUID->"1340d16c-b92d-48f7-bd5a-\
124cda63c945"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"(*", 
   RowBox[{
   "Define", " ", "the", " ", "variable", " ", "representing", " ", "a", " ", 
    "single", " ", "step", " ", "in", " ", "x"}], "*)"}], 
  RowBox[{
   RowBox[{
    RowBox[{"z", "=", 
     RowBox[{"Exp", "[", 
      RowBox[{"I", " ", "Pi", " ", "kx"}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", "\n", 
   RowBox[{"(*", 
    RowBox[{
    "Function", " ", "to", " ", "extract", " ", "the", " ", "hopping", " ", 
     "matrix", " ", "for", " ", "a", " ", 
     RowBox[{"distance", "'"}], 
     RowBox[{"n", "'"}]}], "*)"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"GetHoppingBlock", "[", 
      RowBox[{"Hmatrix_", ",", "n_"}], "]"}], ":=", 
     RowBox[{"Module", "[", 
      RowBox[{
       RowBox[{"{", "temp", "}"}], ",", 
       RowBox[{"(*", 
        RowBox[{"Replace", " ", 
         RowBox[{"Exp", "[", 
          RowBox[{"I", " ", "n", " ", "Pi", " ", "kx"}], "]"}], " ", "with", " ", 
         RowBox[{"z", "^", "n"}]}], "*)"}], 
       RowBox[{
        RowBox[{"temp", "=", 
         RowBox[{"Hmatrix", "/.", " ", 
          RowBox[{
           RowBox[{"Exp", "[", 
            RowBox[{
             RowBox[{"Complex", "[", 
              RowBox[{"0", ",", "val_"}], "]"}], " ", "Pi", " ", "kx"}], 
            "]"}], ":>", 
           RowBox[{"z", "^", 
            RowBox[{"(", "val", ")"}]}]}]}]}], ";", "\[IndentingNewLine]", 
        RowBox[{"(*", 
         RowBox[{"Extract", " ", "the", " ", "coefficient", " ", "of", " ", 
          RowBox[{"z", "^", "n"}]}], "*)"}], 
        RowBox[{"Map", "[", 
         RowBox[{
          RowBox[{
           RowBox[{"Coefficient", "[", 
            RowBox[{
             RowBox[{"Expand", "[", "#", "]"}], ",", "z", ",", "n"}], "]"}], 
           "&"}], ",", "temp", ",", 
          RowBox[{"{", "2", "}"}]}], "]"}]}]}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{"Extract", " ", "blocks"}], "*)"}], "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
     RowBox[{"H0", " ", "is", " ", 
      RowBox[{"the", "'"}], "On"}], "-", 
     RowBox[{
      RowBox[{"site", "'"}], " ", "block", " ", 
      RowBox[{"(", 
       RowBox[{
       "diagonal", " ", "blocks", " ", "in", " ", "the", " ", "ribbon"}], 
       ")"}]}]}], "*)"}], "\n", 
   RowBox[{"H0", "=", 
    RowBox[{"GetHoppingBlock", "[", 
     RowBox[{"Hfinal2", ",", "0"}], "]"}]}], "\[IndentingNewLine]", "\n", 
   RowBox[{"(*", 
    RowBox[{"H1", " ", "is", " ", 
     RowBox[{"the", "'"}], "Nearest", " ", 
     RowBox[{"Neighbor", "'"}], " ", "hopping", " ", 
     RowBox[{"(", 
      RowBox[{
       RowBox[{"e", ".", "g", "."}], ",", 
       RowBox[{"x", "->", 
        RowBox[{"x", "+", "a"}]}]}], ")"}]}], "*)"}], "\[IndentingNewLine]", 
   RowBox[{"H1", "=", 
    RowBox[{"GetHoppingBlock", "[", 
     RowBox[{"Hfinal2", ",", "1"}], "]"}]}], "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{"Hm1", " ", "=", 
    RowBox[{"GetHoppingBlock", "[", 
     RowBox[{"Hfinal2", ",", 
      RowBox[{"-", "1"}]}], "]"}]}], "\[IndentingNewLine]", 
   "\[IndentingNewLine]", "\n", 
   RowBox[{"(*", 
    RowBox[{
    "Hm1", " ", "is", " ", "the", " ", "hopping", " ", "in", " ", "the", " ", 
     "opposite", " ", "direction", " ", 
     RowBox[{"(", 
      RowBox[{"x", "->", 
       RowBox[{"x", "+", 
        RowBox[{"2", "a"}]}]}], ")"}]}], "*)"}], "\[IndentingNewLine]", 
   RowBox[{"H2", "=", 
    RowBox[{"GetHoppingBlock", "[", 
     RowBox[{"Hfinal2", ",", "2"}], "]"}]}], "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
    "Check", " ", "Hermiticity", " ", "of", " ", "the", " ", "components"}], 
    "*)"}], 
   RowBox[{
    RowBox[{"Hm1", "=", 
     RowBox[{"GetHoppingBlock", "[", 
      RowBox[{"Hfinal2", ",", 
       RowBox[{"-", "1"}]}], "]"}]}], ";"}], "\n", 
   RowBox[{"Hm2", "=", 
    RowBox[{"GetHoppingBlock", "[", 
     RowBox[{"Hfinal2", ",", 
      RowBox[{"-", "2"}]}], "]"}]}], "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
     RowBox[{"Assuming", " ", "m"}], ",", "t1", ",", "t2", ",", "delta", ",", 
     
     RowBox[{"ky", " ", "are", " ", "all", " ", "real"}]}], "*)"}], 
   RowBox[{
    RowBox[{
     RowBox[{"HermitianCheck", "[", 
      RowBox[{"A_", ",", "B_"}], "]"}], ":=", 
     RowBox[{
      RowBox[{"FullSimplify", "[", 
       RowBox[{
        RowBox[{"A", "-", 
         RowBox[{"ConjugateTranspose", "[", "B", "]"}]}], ",", 
        RowBox[{"Assumptions", "->", 
         RowBox[{"Element", "[", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"m", ",", "t1", ",", "t2", ",", "\[Delta]", ",", "ky"}], 
            "}"}], ",", "Reals"}], "]"}]}]}], "]"}], "==", 
      RowBox[{"ConstantArray", "[", 
       RowBox[{"0", ",", 
        RowBox[{"Dimensions", "[", "A", "]"}]}], "]"}]}]}], ";"}], "\n", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"Print", "[", 
     RowBox[{"\"\<H0 is Hermitian: \>\"", ",", 
      RowBox[{"HermitianCheck", "[", 
       RowBox[{"H0", ",", "H0"}], "]"}]}], "]"}], ";"}], "\n", 
   RowBox[{
    RowBox[{"Print", "[", 
     RowBox[{"\"\<H-1 is H1 adjoint: \>\"", ",", 
      RowBox[{"HermitianCheck", "[", 
       RowBox[{"Hm1", ",", "H1"}], "]"}]}], "]"}], ";"}], "\n", 
   RowBox[{
    RowBox[{"Print", "[", 
     RowBox[{"\"\<H-2 is H2 adjoint: \>\"", ",", 
      RowBox[{"HermitianCheck", "[", 
       RowBox[{"Hm2", ",", "H2"}], "]"}]}], "]"}], ";"}], "\n"}]}]], "Input",
 CellChangeTimes->{{3.978313456019074*^9, 3.9783135087995863`*^9}, {
   3.978313797621551*^9, 3.978313798659205*^9}, 3.978319847204153*^9},
 CellLabel->"In[21]:=",ExpressionUUID->"0f1d8b39-2db4-4462-a887-ba7d55d0022f"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"-", 
      FractionBox["3", "2"]}], ",", "0", ",", 
     RowBox[{"0.`", "\[VeryThinSpace]", "+", 
      RowBox[{"0.`", " ", "\[ImaginaryI]"}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"0", ",", 
     RowBox[{
      FractionBox["1", "4"], " ", 
      SuperscriptBox["\[ExponentialE]", 
       RowBox[{
        RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]], 
      " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "1"}], "-", 
        RowBox[{"6", " ", 
         SuperscriptBox["\[ExponentialE]", 
          RowBox[{"2", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "-", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"4", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], 
       ")"}]}], ",", 
     RowBox[{
      RowBox[{"(", 
       RowBox[{"0.`", "\[VeryThinSpace]", "+", 
        RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
      SuperscriptBox["\[ExponentialE]", 
       RowBox[{
        RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]], 
      " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "1.`"}], "+", 
        RowBox[{"2.`", " ", 
         SuperscriptBox["\[ExponentialE]", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "-", 
        RowBox[{"2.`", " ", 
         SuperscriptBox["\[ExponentialE]", 
          RowBox[{"3", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "+", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"4", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], 
       ")"}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"0.`", "\[VeryThinSpace]", "+", 
      RowBox[{"0.`", " ", "\[ImaginaryI]"}]}], ",", 
     RowBox[{
      RowBox[{"(", 
       RowBox[{"0.`", "\[VeryThinSpace]", "+", 
        RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
      SuperscriptBox["\[ExponentialE]", 
       RowBox[{
        RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]], 
      " ", 
      RowBox[{"(", 
       RowBox[{
        RowBox[{"-", "1.`"}], "+", 
        RowBox[{"2.`", " ", 
         SuperscriptBox["\[ExponentialE]", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "-", 
        RowBox[{"2.`", " ", 
         SuperscriptBox["\[ExponentialE]", 
          RowBox[{"3", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "+", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"4", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], 
       ")"}]}], ",", 
     RowBox[{"0.25`", " ", 
      SuperscriptBox["\[ExponentialE]", 
       RowBox[{
        RowBox[{"-", "2"}], " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]], 
      " ", 
      RowBox[{"(", 
       RowBox[{"1", "-", 
        RowBox[{"4.`", " ", 
         SuperscriptBox["\[ExponentialE]", 
          RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "-", 
        RowBox[{"4.`", " ", 
         SuperscriptBox["\[ExponentialE]", 
          RowBox[{"3", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], "+", 
        SuperscriptBox["\[ExponentialE]", 
         RowBox[{"4", " ", "\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}], 
       ")"}]}]}], "}"}]}], "}"}]], "Output",
 CellChangeTimes->{{3.978313487420353*^9, 3.978313511250168*^9}, 
   3.978313815395134*^9, 3.978314053723016*^9, {3.9783145127574377`*^9, 
   3.978314526318674*^9}, 3.9783149020921993`*^9, 3.978324958983614*^9, 
   3.978325239585577*^9, 3.9783252719399967`*^9, 3.978325616161064*^9, 
   3.9783294183474283`*^9},
 CellLabel->"Out[23]=",ExpressionUUID->"d4a28731-e582-4b34-a280-6ec73230ad18"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"0", ",", 
     RowBox[{
      RowBox[{
       FractionBox["1", "4"], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "-", 
      RowBox[{
       FractionBox["1", "4"], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}], ",", 
     RowBox[{
      RowBox[{"(", 
       RowBox[{"0.`", "\[VeryThinSpace]", "-", 
        RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      RowBox[{
       FractionBox["1", "4"], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "-", 
      RowBox[{
       FractionBox["1", "4"], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}], ",", "0", ",", 
     RowBox[{
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "-", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      RowBox[{"(", 
       RowBox[{"0.`", "\[VeryThinSpace]", "-", 
        RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}], ",", 
     RowBox[{
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "-", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}], ",", 
     RowBox[{
      RowBox[{"-", "1.`"}], "+", 
      RowBox[{"0.5`", " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{"0.5`", " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}]}], "}"}]}], 
  "}"}]], "Output",
 CellChangeTimes->{{3.978313487420353*^9, 3.978313511250168*^9}, 
   3.978313815395134*^9, 3.978314053723016*^9, {3.9783145127574377`*^9, 
   3.978314526318674*^9}, 3.9783149020921993`*^9, 3.978324958983614*^9, 
   3.978325239585577*^9, 3.9783252719399967`*^9, 3.978325616161064*^9, 
   3.9783294183512897`*^9},
 CellLabel->"Out[24]=",ExpressionUUID->"8f150d74-d4f0-4a33-ac08-72a93df442e5"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{"0", ",", 
     RowBox[{
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{
       FractionBox["1", "4"], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}], ",", 
     RowBox[{
      RowBox[{"(", 
       RowBox[{"0.`", "\[VeryThinSpace]", "+", 
        RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], "-", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "-", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "4"]}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{
       FractionBox["1", "4"], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}], ",", "0", ",", 
     RowBox[{
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "-", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{
      RowBox[{"(", 
       RowBox[{"0.`", "\[VeryThinSpace]", "+", 
        RowBox[{"0.5`", " ", "\[ImaginaryI]"}]}], ")"}], "-", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "-", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}], ",", 
     RowBox[{
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "-", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{
       RowBox[{"(", 
        RowBox[{"0.`", "\[VeryThinSpace]", "+", 
         RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ")"}], " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}], ",", 
     RowBox[{
      RowBox[{"-", "1.`"}], "+", 
      RowBox[{"0.5`", " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{
         RowBox[{"-", "\[ImaginaryI]"}], " ", "ky", " ", "\[Pi]"}]]}], "+", 
      RowBox[{"0.5`", " ", 
       SuperscriptBox["\[ExponentialE]", 
        RowBox[{"\[ImaginaryI]", " ", "ky", " ", "\[Pi]"}]]}]}]}], "}"}]}], 
  "}"}]], "Output",
 CellChangeTimes->{{3.978313487420353*^9, 3.978313511250168*^9}, 
   3.978313815395134*^9, 3.978314053723016*^9, {3.9783145127574377`*^9, 
   3.978314526318674*^9}, 3.9783149020921993`*^9, 3.978324958983614*^9, 
   3.978325239585577*^9, 3.9783252719399967`*^9, 3.978325616161064*^9, 
   3.9783294183550367`*^9},
 CellLabel->"Out[25]=",ExpressionUUID->"5b4b20ff-d6e7-4c6a-b8b3-f474eb517ae2"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"-", 
      FractionBox["1", "4"]}], ",", "0", ",", 
     RowBox[{"0.`", "\[VeryThinSpace]", "+", 
      RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"0.`", "\[VeryThinSpace]", "+", 
      RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ",", "0", ",", "0.25`"}], 
    "}"}]}], "}"}]], "Output",
 CellChangeTimes->{{3.978313487420353*^9, 3.978313511250168*^9}, 
   3.978313815395134*^9, 3.978314053723016*^9, {3.9783145127574377`*^9, 
   3.978314526318674*^9}, 3.9783149020921993`*^9, 3.978324958983614*^9, 
   3.978325239585577*^9, 3.9783252719399967`*^9, 3.978325616161064*^9, 
   3.978329418358096*^9},
 CellLabel->"Out[26]=",ExpressionUUID->"ab3c45c4-4016-486d-9280-394e11d0d293"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"-", 
      FractionBox["1", "4"]}], ",", "0", ",", 
     RowBox[{"0.`", "\[VeryThinSpace]", "-", 
      RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}]}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{"0", ",", "0", ",", "0"}], "}"}], ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"0.`", "\[VeryThinSpace]", "-", 
      RowBox[{"0.25`", " ", "\[ImaginaryI]"}]}], ",", "0", ",", "0.25`"}], 
    "}"}]}], "}"}]], "Output",
 CellChangeTimes->{{3.978313487420353*^9, 3.978313511250168*^9}, 
   3.978313815395134*^9, 3.978314053723016*^9, {3.9783145127574377`*^9, 
   3.978314526318674*^9}, 3.9783149020921993`*^9, 3.978324958983614*^9, 
   3.978325239585577*^9, 3.9783252719399967`*^9, 3.978325616161064*^9, 
   3.978329418359806*^9},
 CellLabel->"Out[28]=",ExpressionUUID->"18d1ec88-cb5b-4c1b-a7f8-4af1d7a41da3"],

Cell[CellGroupData[{

Cell[BoxData[
 InterpretationBox[
  RowBox[{"\<\"H0 is Hermitian: \"\>", "\[InvisibleSpace]", "True"}],
  SequenceForm["H0 is Hermitian: ", True],
  Editable->False]], "Print",
 CellChangeTimes->{{3.978313487624693*^9, 3.978313511274056*^9}, 
   3.978314053961481*^9, 3.978314526336474*^9, 3.9783249595258408`*^9, 
   3.9783252396832647`*^9, 3.978325271961515*^9, 3.978325616177602*^9, 
   3.978329418445478*^9},
 CellLabel->
  "During evaluation of \
In[21]:=",ExpressionUUID->"ecbd28a4-22d7-4c16-ad10-df2eefd87ad2"],

Cell[BoxData[
 InterpretationBox[
  RowBox[{"\<\"H-1 is H1 adjoint: \"\>", "\[InvisibleSpace]", "True"}],
  SequenceForm["H-1 is H1 adjoint: ", True],
  Editable->False]], "Print",
 CellChangeTimes->{{3.978313487624693*^9, 3.978313511274056*^9}, 
   3.978314053961481*^9, 3.978314526336474*^9, 3.9783249595258408`*^9, 
   3.9783252396832647`*^9, 3.978325271961515*^9, 3.978325616177602*^9, 
   3.978329418448048*^9},
 CellLabel->
  "During evaluation of \
In[21]:=",ExpressionUUID->"17bb0ab3-05c5-49e2-beeb-175521372910"],

Cell[BoxData[
 InterpretationBox[
  RowBox[{"\<\"H-2 is H2 adjoint: \"\>", "\[InvisibleSpace]", "True"}],
  SequenceForm["H-2 is H2 adjoint: ", True],
  Editable->False]], "Print",
 CellChangeTimes->{{3.978313487624693*^9, 3.978313511274056*^9}, 
   3.978314053961481*^9, 3.978314526336474*^9, 3.9783249595258408`*^9, 
   3.9783252396832647`*^9, 3.978325271961515*^9, 3.978325616177602*^9, 
   3.978329418450437*^9},
 CellLabel->
  "During evaluation of \
In[21]:=",ExpressionUUID->"b94b0343-ef36-4d7c-9382-c692bb850478"]
}, Open  ]]
}, Open  ]],

Cell[BoxData[""], "Input",
 CellChangeTimes->{{3.978313631916912*^9, 3.978313631916963*^9}, {
   3.9783138322920322`*^9, 3.978313833522586*^9}, 
   3.978313960288479*^9},ExpressionUUID->"bad43479-a4f7-4d3a-aca1-\
88961985c62f"],

Cell[BoxData[""], "Input",
 CellChangeTimes->{{3.978313669225855*^9, 3.978313669225903*^9}, {
   3.978313857531612*^9, 3.978313858588669*^9}, 
   3.978313967299384*^9},ExpressionUUID->"2e815ed6-5425-4fc3-b7ec-\
d8a988490691"],

Cell[BoxData[""], "Input",
 CellChangeTimes->{{3.978319933556418*^9, 
  3.978319933564823*^9}},ExpressionUUID->"a161731d-6117-45cd-b46a-\
8470cc050ac7"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{
    RowBox[{"BuildRibbonMat", "[", 
     RowBox[{"kInput_", ",", "W_Integer"}], "]"}], ":=", 
    RowBox[{"Module", "[", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{
       "h0", ",", "h1", ",", "h2", ",", "hm1", ",", "hm2", ",", "rules"}], 
       "}"}], ",", 
      RowBox[{
       RowBox[{"rules", "=", 
        RowBox[{"{", 
         RowBox[{"ky", "->", "kInput"}], "}"}]}], ";", "\[IndentingNewLine]", 
       
       RowBox[{"(*", 
        RowBox[{
        "Substitution", " ", "must", " ", "happen", " ", "inside", " ", "the",
          " ", "module", " ", "using", " ", "the", " ", "input", " ", 
         "value"}], "*)"}], 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"h0", ",", "h1", ",", "h2", ",", "hm1", ",", "hm2"}], "}"}], 
        "=", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"H0", ",", "H1", ",", "H2", ",", "Hm1", ",", "Hm2"}], "}"}],
          "/.", " ", "rules"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"ArrayFlatten", "[", 
        RowBox[{"Table", "[", 
         RowBox[{
          RowBox[{"Which", "[", 
           RowBox[{
            RowBox[{"i", "==", "j"}], ",", "h0", ",", 
            RowBox[{"j", "==", 
             RowBox[{"i", "+", "1"}]}], ",", "h1", ",", 
            RowBox[{"j", "==", 
             RowBox[{"i", "-", "1"}]}], ",", "hm1", ",", 
            RowBox[{"j", "==", 
             RowBox[{"i", "+", "2"}]}], ",", "h2", ",", 
            RowBox[{"j", "==", 
             RowBox[{"i", "-", "2"}]}], ",", "hm2", ",", "True", ",", 
            RowBox[{"ConstantArray", "[", 
             RowBox[{"0", ",", 
              RowBox[{"{", 
               RowBox[{"3", ",", "3"}], "}"}]}], "]"}]}], "]"}], ",", 
          RowBox[{"{", 
           RowBox[{"i", ",", "1", ",", "W"}], "}"}], ",", 
          RowBox[{"{", 
           RowBox[{"j", ",", "1", ",", "W"}], "}"}]}], "]"}], "]"}]}]}], 
     "]"}]}], ";"}], "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"(*", 
   RowBox[{"Define", " ", "Numerical", " ", "Constants"}], "*)"}], 
  RowBox[{
   RowBox[{"m", "=", "1.0"}], ";", 
   RowBox[{"t1", "=", "1.0"}], ";", 
   RowBox[{"t2", "=", "0"}], ";", 
   RowBox[{"\[Delta]", "=", "0"}], ";"}]}], "\n", 
 RowBox[{
  RowBox[{
   RowBox[{"W", "=", "80"}], ";"}], " ", 
  RowBox[{"(*", 
   RowBox[{
    RowBox[{
    "Number", " ", "of", " ", "unit", " ", "cells", " ", "in", " ", "the", " ",
      "x"}], "-", "direction"}], "*)"}]}], "\n", 
 RowBox[{
  RowBox[{
   RowBox[{"kyVals", "=", 
    RowBox[{"Range", "[", 
     RowBox[{
      RowBox[{"-", "1"}], ",", "1", ",", "0.05"}], "]"}]}], ";"}], " ", 
  RowBox[{"(*", 
   RowBox[{"k", "-", 
    RowBox[{
    "points", " ", "along", " ", "the", " ", "infinite", " ", "direction"}]}],
    "*)"}], "\[IndentingNewLine]", "\n", 
  RowBox[{"(*", 
   RowBox[{
   "Share", " ", "definitions", " ", "with", " ", "Parallel", " ", 
    "Kernels"}], "*)"}]}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"DistributeDefinitions", "[", 
    RowBox[{
    "H0", ",", "H1", ",", "H2", ",", "Hm1", ",", "Hm2", ",", "BuildRibbonMat",
      ",", "m", ",", "t1", ",", "t2", ",", "\[Delta]"}], "]"}], ";"}], 
  "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"(*", 
   RowBox[{"Compute", " ", "Eigenvalues"}], "*)"}], 
  RowBox[{
   RowBox[{"eigenvalsListSorted", "=", 
    RowBox[{"ParallelMap", "[", 
     RowBox[{
      RowBox[{
       RowBox[{"Sort", "[", 
        RowBox[{"Re", "[", 
         RowBox[{"Eigenvalues", "[", 
          RowBox[{"N", "[", 
           RowBox[{"BuildRibbonMat", "[", 
            RowBox[{"#", ",", "W"}], "]"}], "]"}], "]"}], "]"}], "]"}], "&"}],
       ",", "kyVals"}], "]"}]}], ";"}], "\[IndentingNewLine]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"(*", 
   RowBox[{"Formatting", " ", "and", " ", "Visualization"}], "*)"}], 
  RowBox[{
   RowBox[{"numBands", "=", 
    RowBox[{"3", "*", "W"}]}], ";"}], "\[IndentingNewLine]", "\n"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{
   RowBox[{"bandData", "=", 
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"Transpose", "[", 
       RowBox[{"{", 
        RowBox[{"kyVals", ",", 
         RowBox[{"eigenvalsListSorted", "[", 
          RowBox[{"[", 
           RowBox[{"All", ",", "i"}], "]"}], "]"}]}], "}"}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"i", ",", "1", ",", "numBands"}], "}"}]}], "]"}]}], ";"}], 
  "\[IndentingNewLine]", "\[IndentingNewLine]", "\[IndentingNewLine]"}], "\n", 
 RowBox[{"ListPlot", "[", 
  RowBox[{"bandData", ",", 
   RowBox[{"Joined", "->", "True"}], ",", 
   RowBox[{"PlotRange", "->", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"-", "3"}], ",", "8"}], "}"}]}], ",", " ", 
   RowBox[{"PlotStyle", "->", 
    RowBox[{"Directive", "[", 
     RowBox[{
      RowBox[{"Opacity", "[", "0.4", "]"}], ",", "Blue"}], "]"}]}], ",", 
   RowBox[{"AxesLabel", "->", 
    RowBox[{"{", 
     RowBox[{"\"\<\\!\\(\\*SubscriptBox[\\(k\\), \\(y\\)]\\)\>\"", 
      ",", "\"\<Energy\>\""}], "}"}]}], ",", "\[IndentingNewLine]", 
   "\[IndentingNewLine]", "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{"PlotLabel", "->", 
    RowBox[{"\"\<Ribbon Band Structure (W=\>\"", "<>", 
     RowBox[{"ToString", "[", "W", "]"}], "<>", "\"\<)\>\""}]}], ",", 
   RowBox[{"ImageSize", "->", "Large"}], ",", 
   RowBox[{"GridLines", "->", "Automatic"}]}], "]"}]}], "Input",
 CellChangeTimes->{{3.9783139959296494`*^9, 3.978313995929696*^9}, {
  3.978314706205699*^9, 3.978314707264312*^9}, {3.9783148025794153`*^9, 
  3.978314836771557*^9}, {3.978314992955023*^9, 3.978314999210866*^9}, {
  3.9783150727923307`*^9, 3.978315140815563*^9}, {3.978315183194149*^9, 
  3.978315185773704*^9}, {3.978315227630166*^9, 3.9783152291893673`*^9}, {
  3.9783193627038527`*^9, 3.9783193967696867`*^9}, {3.978319818359972*^9, 
  3.978319833170203*^9}, {3.9783252575100193`*^9, 3.9783252579497232`*^9}, {
  3.9783255079086933`*^9, 3.978325510717166*^9}, {3.9783255520365868`*^9, 
  3.978325555989339*^9}, {3.9783256492359962`*^9, 3.97832568004955*^9}, {
  3.978329386836075*^9, 3.978329387850119*^9}},
 CellLabel->"In[33]:=",ExpressionUUID->"cf6f07b5-e9d1-44d7-801a-af7e93ff9b68"],

Cell[BoxData[
 GraphicsBox[{{}, 
   InterpretationBox[{
     TagBox[{{}, {}, 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTsKwkAQhhcbHwkBCR7AdHaiFnZzB48gKHZexVLFwtYjpFrBKhAlIAiC
hRIJhoSQI0h2NgM708z+zMw3j+3P17NFQwgxEEJUHq2UHXycl8oKaWt9DSvL
paX1WFlGer+rLJWe1uh+0jV4iexqrXDhl/FixvtIx+C9KY71L9nSeqvyn6Sx
34P2GSn+nerRRbQf1geUP1T5F9IY90lvlD4xnhBNrY8YB9vQPrS1niIfLCMe
AJuP6ic4P9T9V7gf8Q64P9VHeB/K1/cDdl9wDH5M+Tf8H+qP/RLomf8LrsFL
wTN4GePlbP6C7VtC/X9/uhK4Uw==
          "]]},
        Annotation[#, "Charting`Private`Tag#1"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkc8KQUEUxicb/0t5AFnaCQu78w4eQZGdV7FEFrYeweooK4VuKaUsiEQk
j6A73/jqOJu5v76Z3zkzt9zutzoJ51zFORevqI+m8LHo+nprJvBmHddL04Hr
vp7Mx6O4HloKjOWuReO7aSGw162vmjW+C/3wnTVvfCfOh/NH8tDvP2jS9Ntz
vpr377gfS8Qc51fkqt+/5DzI5+SB5xn594K//lPkkjI8Jzfhl7TJV5Ixvojc
wPw838P9yBPcnxzhfcTOd2Ie3lfyxn9hvsX/kZzpdxP7P+5SNL6HlIzvyfnh
e5Hhe//d98P+X2vyuBU=
          "]]},
        Annotation[#, "Charting`Private`Tag#2"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKAjEMhoODeuLBTe6ObqIObnkHH0FQ3HwVRxUHVx/BqYLTwSkHgiA4
KIooitwjyDX1hzRL+5H2S9LW++PeoEBEDSLKV4nMlGWzGdr4morjXZLHxwSO
2zbeyM9nebxMzbEsTxMp3wNsdcnd893A4ruaUPku6E/un8FTe/5kSqreEf21
rP+A87KkqCf3Y3DTnt96/jXyE8srz0dUdLyUPJcVr8Fd8Xv5mAPlS8Ed6Z//
841kPtxfyPzgVN6HdX8XsHtfDpX/Bv9e/ocrqt6Dq/p/OVK+F9eU743+xfdB
ffF9vXkz9PsDOpK36Q==
          "]]},
        Annotation[#, "Charting`Private`Tag#3"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhcLTaJgCi9gaSdqYTd38AiCYudVLFUsbD1CqhWsBJWAIAgW
ESUYlJAjSHaWD2anmX3M7Jv9aY/no0lFKdVRSpWZo9AeL/ZTE7n2LZ9PZfxQ
75v46sDyelVGpluWOX10KHypblo2utPb8b0wj31P3RC+RNfE/gd4afrvYJ53
g69n/FfM4xSDef8R3DX9B6cegReGd45PqarlLdfJExyBh+ynmqgfyTkfeMDn
R/+M7wfe8P3RH/P7OL4E/fZ9qSH8L9Qv/D8UiHkp1eX/Uih8GbWE74v57PuB
2ZeTL3wF5v8BGoK30Q==
          "]]},
        Annotation[#, "Charting`Private`Tag#4"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTsKwkAURQdB8mkMZAWWdqIWdrMHlyAodm7FUsXC1iWkGsEqECUgCIJF
JBIMCSFLkMwbL7y8ZuZwZ86bT3++ni06QoiBEKIZqWpl0+S81FUpx/A1aqpE
PtZVIN/vmsqVb5iGr/KYL1M9w1oXfVq+tOV7K5f5EmWx/S/wVq9/gqnfA76R
9t+R0xCjP+0PkQ/1+ksrD8AbzSfw/wW7ho+US5txAJ6SX1osDyX3xeAJnR/r
V3Q/8IHuD47pfSS/bwI27ytd5k+R3+h/pMP6ZWDzv9Jjvlz6zFfg/OQrweSr
Wr4a5/0BCTq3wg==
          "]]},
        Annotation[#, "Charting`Private`Tag#5"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhoOg1S6F3sDRTdTB7d3BIwiKm1dxVHFw9QidIjgVqhQEQXCo
VIpSKT2CNC/+8PqW5ONPvuQl3elyMmsopXpKqWrkKnWbJ8e5qUJ3LJ+jqr7I
h6Zy5NtNVR/tW+bhrT3hy8BGF71qvhTMvqd2hS/Rjtj/AK/N+juYz7vBNzD+
K3Ie4tr+ENw360/Yz3mAfGX4gPz/gk3Le86pLTgAj9lPjshDkr4Y+YjvTy3L
C+4P+Y77Rx7z+5DsNwHb9yVX+FPkF/4f6ojzMrD9X/KE70O+8OXoh31fMPuK
mq/EfX/6o7e3
          "]]},
        Annotation[#, "Charting`Private`Tag#6"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhoOg1Q4VegNHN1EHt9zBIwiKm1dxVHFw9QidIjgVqhQEQXCo
VIqlpXgEaV784eUt6cf/+iUv6c1W03lDCNEXQtQr1Ve16eO00FWBL1FdJXik
qwDvtnXlyjdMy0d5zJeprmGti97KYb7U8r2Uy3wJ+un/J3ij+x9g2u8O31D7
b8hpia3/Q/BA95+tPACvNR/h/99g0/CBcukwDsAT8ssWy0PJfTH6x3R+9C9p
PuR7mh95TPcj+bwJ2NyvdJk/RX6l95Edtl8GNu8rPebLpc98BeYhXwkmX2X5
vjjvD+w7t64=
          "]]},
        Annotation[#, "Charting`Private`Tag#7"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRfBxBRpcgNLO1ELu72DRxAUO69iqWJh6xGsVrASogQEQbBQ
FIkYQo4g2b9+mEwzeczsm91JczgdjGpKqZZSqsyIwvj42I1t5Kbh+BiXkZG7
Nr7k5aKMj4kcI6UmFL432eriF+fB96z4HiYQvjv7cf5mPMdz238lY96Fvo71
n1lHSujD+QO5bfv3lfqWPLO8of+/wbrjNeraF7wl9+HXnqgftPQl7O/h/uyf
4H3kFd5PTrAfLd97p8/tVwfC/2T9hP/D+2Deu3K/VIfC99GR8H3ZD19GP3x5
xVew/gPYS7ee
          "]]},
        Annotation[#, "Charting`Private`Tag#8"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRfBmBQ2uYGlnaiF3dzBIwiKnVexVLGw9QipVrASVAKCIFgo
iiQkhBxBsrP5MDvN5DE7b3Y2ncliPG0opbpKqSpzlLrFH4eZiQJ8OVeRa9/y
wEQG3qyrSHVomVOi28L3Axvd+Qs/+z6O760D4XtpT/Q/wStz/gHmeXf4+sZ/
Q51TjPncf0K9Z84fnXoEXhrew1+/YNPyjuvkCY6o7h+x36mfULf3Aw/5/lT7
57wf+re8Pzjm9yG57wts35cC4f9g3pX/D/li3o/kvgm1hS+lUPgyx5eD2Vc4
vhL7/wHOW7eW
          "]]},
        Annotation[#, "Charting`Private`Tag#9"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoNgrUMHfQNHN1EHt7yDjyAobr6Ko4qDq4/QKYJToUpBEASH
SqVYWkofQZpLf7jccvm43JfkMlhs5suWEGIohKgzRaU6tLisdJTgW1hHAZ7o
yJVr+LCvI1N9w5R+ymO+FKx14dfyJZbvo7rMFyuH9b/BO73/BabznvCPtf+B
OqUIdeoPUB/p/VfL74O3ms/obybYNnyiunQY++AZ+a16ILkvAk/p/rLxr+l9
6D/S+8ERzUfy98ZgM1/ZZf4E593pf6TLzkvB5n+lx3yZ7DFfbvkKMPlKy1fh
vn/Ei7eO
          "]]},
        Annotation[#, "Charting`Private`Tag#10"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhoNgbaGCHsHRTdTBLXfwCILi5lUcVRxcPUKnCE6FKgVBEByU
ilhaSo8gzUt/eHlL+vEn30tee7PVdN4QQvSFENVKVaoWfZwWugrwJaoqB490
ZeDdtqpUdQ3T8lM+831V27DWRR/LlyiX+d7KY76Xctj5p2oa3uj9DzD1u2P/
UPtvyGmJkdP5EPlA7z9beQBeaz7i/vUE6/MHyqXDOABPyG/loeS+GPmY7i9r
/5Leh3xP7wfHNB+wmR/YzFd6zJ+g/5X+D5j6faXLfD/pM18qO8yXWb7c8hWW
r8R9/7GDt4E=
          "]]},
        Annotation[#, "Charting`Private`Tag#11"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRfBJEUQr2BpJ2phN3fwCIJi51UsVSxsPYLVClaBKAFBECwU
JSQkhBxBspN8mJ1m8/g7b2c3vdlqOm8ppfpKqWrlKrXLH+eFqQJ8DavKwSNT
GXi3rSrV3Zp5SbQvfDHY6MKf5ftavo/2hO+tHdH/0u2aN2b/E8znPbB/aPx3
5LxEyLk/QD4w+y9WfgKvDR/BzQs2/QfOyRF8Ak/Yb+UBucIXIR/z/NT4l3w/
5Hu+Pzji9yE53xtcvy95wv9FfuP/g3n4vJjk/0jIF76UOsKXoZ99ueUrLF+J
ef+mC7d4
          "]]},
        Annotation[#, "Charting`Private`Tag#12"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoOo7SB9B0c3UQe3ewcfQVDcfBVHFQdXH6FTBCdBpSAIgkOl
IpaW0keQ5tIfLrckH3f35ZJ0p8vJrKGU6imlqpWj1G3eHOcmCu1Zvl6qyMFD
Exl4u6ki1YFlXn66I3xfsNFdPjiPfYnje2tf+GLUc/9LtyyvTf0TzOc9UD8w
/jvyvETIc/8Z+b6pPzn5ELwyfADXL1j37zlPbcEheMx+kvVn8oQvQv2I56em
5QXfD/07vj844vchOV8Mtu9LvvAnyN/4fzAPn/cl+R8/6ghfSoHwZY4vd3yF
4ysx7x+ZA7dv
          "]]},
        Annotation[#, "Charting`Private`Tag#13"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhfRKERyB0s7UQu7uYNHEBQ7r2KpYmHrEVKtYBWIEhAEwSIS
CZGIeATJzvrB7DS7j2/27V9nshhPa0qprlKqGrm+2uPJYWbqo5uWT3FVb/DA
VAnerKt66cAyD4X2hS/XbctGFz+xH/syx/fQLeFL0c/r77pheWX6b2De74r+
vvFfkPOQOOsjcM/0H7Ge8xD50vAe+f8F//mOc/IEh+AR+0n2R9QUvgT5kM9P
dctzvh/yLd8fnPD7kDxfCrbvSy3hz5Cf+X/AvF9O8j8K8oXvRYHwlY7v7fg+
ju+L8/4Akdu3aA==
          "]]},
        Annotation[#, "Charting`Private`Tag#14"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KAkEMhQfxD0TvYGknamGXO3gEQbHzKpYqFrYeYasRrIRVFgRBsFAU
cdlFPILsvPVBJk3m4yVvJpnmcDoYFYwxLWNMlhFfW8ZhO3bxIR/CLFJy10Vi
KzkvF1nEtpEz0tvWlN+L7OzCp+f3IMPvTn+kmy2p/it57uovZNx3pl/H+Z+o
I0Ve/57cdvU79kMPqM8cb6j/N/jX19ClrDgg9+Evun4vet6Ieg/vl2LOE8xH
fYX5yRH2I/p9N+r5fnkf/B+sP+J/yLjvJVX9v1JTfrHUlV/i+aWe38eb98v3
/gCDS7de
          "]]},
        Annotation[#, "Charting`Private`Tag#15"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhcxSSE5hKWdqIXd3MEjCIqdV7FUsbD1CKlWsApECQiCYBGJ
hAQl5AiSneSD2Wl2H9/um/3pz9ezRUcpNVBK1SNXpV2enJemSvA1qusHHpv6
aq/h/a6uQvsN85DrnvBlYKOLPpYvBbPvDT8PiXbE/hd4a9Y/wdzvAd/I+O+6
K3yxtT8ED836i5UH4I3hE/ztC7b+I+fkCg7AU/aTI/KQpC9GPuHzU+tf8f2Q
H/j+4Jjfx/IlyJv3JU/4U+Q3/h8w98tI/kdOPeEryBe+L/qz7wdmX2n5Kpz3
D3ort1Y=
          "]]},
        Annotation[#, "Charting`Private`Tag#16"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhfRBCI5hKWdqIXd3sEjCIqdV7FUsbD1CFYrWAWiBARBsIhE
QkJCyBEkO9kPZqfZfczMm/0ZLDbzZUcIMRRCNCtFrRzaXFc6KvA9bKIET3QU
ym35sG8iV37LtGTKY75U9VvWuvBn+RIw+b7w0xKrHuv/gHe6/g2meS/4xtr/
VF3mi6z+ADzS9TcrfwFvNZ/hNy9o/CfKS4fxRZr+GfnBlA8k90XIT+n80vjX
dD/wke6P+ojex/LFyLfvK13mT5B/0P+AaV4q+X9k0mO+XPrMV2A++UrLV1nn
q8F/dVu3UA==
          "]]},
        Annotation[#, "Charting`Private`Tag#17"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb8KwjAQh4NoC/55CEc3UQe3ewcfQVDcfBVHFQdXH6FTBKdClYIgCA6V
SmlpKX0EaS79QXJL8nF3Xy7JcLldrFpCiJEQol45KtnhzXWtopSO5ntQRwGe
qsjBx0MdmRxo5iWVXcOXyJ5mpQt+li+2fF/pGr4I83H/R7Y171X925r/BZ4o
/xP1vIRWvw8eq/ob+jnvIb9TfMG8zQs2+TPnyTHYo8Y3Zz+Y8z6ZvpAa34zn
B2/4fuAT3x8c8vtYvgjn6fcl1/DHyD/4f8B8XkLmf6TUNXwZ9Q1fjvPZV1i+
0pqvAv8BZlu3Rg==
          "]]},
        Annotation[#, "Charting`Private`Tag#18"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoNYi6Uv4egm6uCWd/ARBMXNV3FUcXD1ETpFcCpUKQiC4KBU
SktL6SNIc+kPl1uSj0u+3F0Gi8182RFCDIUQzUpRK4c2l5WOSvUM36ImSvBE
RwE+7JvIlW+Ylkx5zJeqvmGti36WL8H75Psql/k+yNP9t+oa3unzL6v+J3is
/Q+cpyW27ofgkT5/xX3KB8hvNZ9RfzvBNn+ivHQYB+AZ+a18KLkvlq1vSvWD
19Qf+Ej9g2OaD/xmftKar3SZP0H+Tv8DpvdSyf8jkx7z5dJnvgL9kK+0fJXV
b416/1vDtz8=
          "]]},
        Annotation[#, "Charting`Private`Tag#19"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoNYi6Uv4egm6uCWd/ARBMXNV3FUcXD1ETpFcCpUKQiC4KBU
SktL6SNIc+kPl1suH5d8yV0Gi8182RFCDIUQTaaolUOLy0pHpXqGb1ETJXii
owAf9k3kyjdMKVMe86Wqb1jroh/uI18CJt9Xucz3QZ3Ov1XX8E7vf1nvf4LH
2v/AfkqxdT4Ej/T+q1UPwFvNZ/TfTrCtn6guHcYBeEZ+qx5K7otl65vS+8Fr
6g98pP7BMc0HfjM/ac1XusyfoH6n/7HuSyX/j0x6zJdLn/kK9EO+En7yVVa/
Nd77B1e7tzw=
          "]]},
        Annotation[#, "Charting`Private`Tag#20"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhoNaxeIlHN1EHdzeHTyCoLh5FUcVB1eP0CmCU6GKIAiCg1IR
xVI8gjR//CF5S/rxv355SZrD6WBUUkq1lFLFivrqAB/bsalcVy3vk6IyctfU
h7xcFPXWDctYXjp0fE9dt2x0yYP7wZeS4bvTj+XGHP9fdcXy3PRfvPnP5I7x
n9iP5ej9H5Pbpn/n5RF5ZnjjzafUP18jl8DhiNyHX9z+mLmdj3kP80vZ8gTn
Y77C+clH3I/nu4l3v1J1/CnzA96HPuz3lJr7vhI6vrc0HN+Hfvgy+uHLxb2/
L+f9AVIjtzc=
          "]]},
        Annotation[#, "Charting`Private`Tag#21"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKAjEQRYO6C65ewtJO1MJu7uARBMXOq1iqWNh6hK0iWC2oLAiCYLGi
iKLIHkE2P35Ippk8ZvIySRqDSX9YUko1lVJFRuS6gsVmZOKrA8v7XREfHVru
mHiTF/MiXrpuGempI8f30FXLRre70w/fjQzflX6kjHXsv3Demek/e/Of2N82
/iPrSKm3PyG3TP/Wq8fkqeE1/f8X/NdXqEvgcEzuwS9ufyKuL2W9i/mlbHmM
+7G+xP3JKd7H82Xiva+Ejv/G/Qf8DxnnPcT9j6dEju8lNcf35nnwfcjwfT1f
znl/SJO3Lw==
          "]]},
        Annotation[#, "Charting`Private`Tag#22"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhoPagu0pHN1EHdxyB48gKG5exVHFwdUjOEVwKlQpCILgUKmU
lpbSI0jz0h9e3pJ8/MmXl2Sw2MyXHSHEUAjRjFS16tHkutJVKcfwPWyqVK7h
ia4CfNg3lSvfMA2Z8pgvVX3DWhf+4CdfAibfF34aYvRH+z/gnV7/tvp/wTfW
/qfqMl9k7Q/AI73+ZuUX8FbzGf72Bdv8RLl0GF/AM/JLvj6Q3Bchn1L/su1/
TfdDfqT7gyN6H8sXIzfvK13mT5A/6H/AdF4q+X9k0mO+XPrMV+B88pWWr7J8
Nfr9A0Hrtyo=
          "]]},
        Annotation[#, "Charting`Private`Tag#23"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhoPagvQUjm6iDm7vDh5BUNy8iqOKg6tHcIrgVKhSEATBoVIp
LRXpEaR5zQ8vb0k+/uTLS9KbrabzllKqr5SqR65Kd3hyXpj6aa/ha1TXV/sN
j0yV4N22rkIHDfOQ667wZWCjiz7wsy8Fs+8NPw8J+uP9L/DGrH86/T/gGxr/
XbeFL3b2h+CBWX9x8hN4bfgIv31Bmx84J0/wiWw+YT/J9SFJX4x8zP2T7X/J
90O+5/uDY34fx5cgb96XfOFPkd/4f8B8XkbyP3LqCl9BgfCVOJ99X8f3c3wV
+v0DPjO3Jw==
          "]]},
        Annotation[#, "Charting`Private`Tag#24"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT8KwjAUh4N/itBTOLqJOrjlDh5BUNy8iqOKg6tH6BTBqVClIAiCQ6VS
WpTSI0jzS3+QvOXl4+V9eUn68/Vs0RJCDIQQdUZUqoPFeamjVF3D16iOn/IM
j3V8yftdHYXyDSPlqmf5MrLWRR/64UvJ8L3pR0o4H/pfqm14q/c/nfkf9I20
/879SLHTH7J/qPdfyKgH5I3mE/3NCzb1I+rS5oA8hd+ph9L2xbKZb4L5ySvc
j/0H3J8c430cX8K6eV/pWf6U9Rv+h4zzMmn/Ry57lq+QvuX78nz4fo6vdHwV
638z07cf
          "]]},
        Annotation[#, "Charting`Private`Tag#25"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoPWUuhTOLqJOrjlHXwEQXHzVRxVHFx9hE4RnApVCoIgOFQq
paWl9BGkufSHyy2Xj7t8uSTD5Xax6gkhRkKINlM0yqHFda2jVgPD96iNCjzV
UYKPhzYK5RumlCuP+TKw1kU/y5davq9ymS/BfLT/o/qG97r/bc3/gm+i/U/0
U4qt/SH2j3X/DUz1ALzTfIG/e8HOd6a6dBgH4Dn5rXoINvPJzjej+cEbuh/6
T3R/cEzvI/l8CermfaXL/CnqD/ofMJ2XSf4fufSYr5A+85U4n3yV5astX4P7
/wEsw7cb
          "]]},
        Annotation[#, "Charting`Private`Tag#26"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoPWUvoWjm6iDm55Bx9BUNx8FUcVB1cfoVMEp0KVgiAIDpVK
aWkpfQRpLv3hckvycZfvLslwuV2sekKIkRCiXSka5dDmutZRq4Hhe9RGBZ7q
KMHHQxuF8g3TkiuP+TKw1kU/9CNfavm+ymW+BPV0/qP6hve6/m3N/4Jvov1P
1NMSW+dDnB/r+huY8gF4p/kCf/eCne9MeekwDsBz8lv5EGzmk51vRvODN3Q/
1J/o/uCY3kfy+RLkzftKl/lT5B/0P2Dql0n+H7n0mK+QPvOV6E++yvLVlq/B
/f8oG7cY
          "]]},
        Annotation[#, "Charting`Private`Tag#27"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhd/QsgtLO1ELez2Dh5BUOy8iqWKha1HSLWClaASEATBQlEk
Ygg5gmS/zQez00weM/sys9sazYbjmlKqrZQqM6IwDXzsJjZy8ulYRmaajns2
fuTVsoyviRwjpSYUvg/Z6o5v+uF7keF7mkD4Hqzj/N3UHS9s/82b/0ruWv+F
/UiJd/7A/o7t35NRj9k/t7zl/tUNVvUN6rohOCYP4PfqB7KbT1e+PuYnT7Ef
eY39yQnux/M9tHe/OhD+F8+f8T7sx/8+Wu6b6lD4vjoSvh/74cs8X67l+xac
9w8dM7cP
          "]]},
        Annotation[#, "Charting`Private`Tag#28"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhoPWIt7C0U3UwS138AiC4uZVHFUcXD1CpxScCioFQRAcKpXS
opQeQZo//SF5S/rx/nx9Sfrz9WzREkIMhBD1iqqUh49wqaskXy91/VTH8FjX
l7zf1VWonmEsuepavoysdZcP/fClZPjeyrd8CfvY/1Jtw1udfzrzP8gj7b8z
jyV29kfMD3X+TEY/YH6j+cTzNzfY9I/oS8/igDyF3+lHZDOfbHwTzC/NW4Ur
nI98wPmZj3E/ji+Rzv1K3/Kn3H/D+zCP/2XSPm8uu5avkD3L92Uevp/jKx1f
xXn/G1u3DA==
          "]]},
        Annotation[#, "Charting`Private`Tag#29"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRReNQXILSztRC7u9g0cQFDuvYqliYesRUm3AKhAlIAiCRSQS
EhJCjiDZ2XyYnWbzmJmXmd3Rardc94QQYyFEe1I0yqGPYKOjBt+jNio1MDzT
UYJPxzYK5RmmI1dD5svAWhf94CdfCibfV7nMl6g+6/+AD7r+bc3/Ak+1/4l6
OmKrP0T9RNffwJT3Ub/XfMX+3Q12+QvlpcPYBy/Ib+VDsJlPdr45zS/NWwVb
2g98pv1RH9P9WL4EeXO/0mX+FPkHvQ/66X+Z5Pvmcsh8hfSYr0Q/+SrLV1u+
BvP+ARiTtwk=
          "]]},
        Annotation[#, "Charting`Private`Tag#30"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhoPWCt7C0U3UwS138AiC4uZVHFUcXD1CpxScCioFQRAcKpXS
opQeQZo//SF5S/LxXr68l/Tn69miJYQYCCHqFVEpD5twqaMkXy91/FTH8FjH
l7zf1VGonmEsuepavoysdZcP/fClZPjeyrd8iWpb51/kra5/Ov0/yCPtv7Me
S+ycj1g/1PVnMvIB6zeaT5y/ecEmf0ReehYH5Cn8Tj4im/5k45ugf2n+Klxh
PvIB87M+xvs4voR5877St/wp8zf8Dxn3ZdKeN5ddy1fInuX78n74fmT4SsdX
sd8/E2O3BQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#31"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhd/IuQWlnaiFnZ7B48gKHZexVLFwtYjpNqAVSBKQBAEi4gi
ESXkCJL9kg9mp9l9zMzb3dnudDmZNZRSPaVUuSIK08ImnNvIyae4jJ9pVzy0
8SVvN2V8jF8xlsx0hO9Ntrr4RT98TzJ8D+MJX2qaov9OXtv6m3P/K3lg/RfW
Y0mc/ojct/VHJx+QV5YP9NcTrPN75LXkQNf1Y/jJyEda+hL2j3B/Xf1VuMD7
yDu8n/UJ5uP4Uuar+WpP+J/Mn/E/ZJz31m3hy3RH+D7aF74vz4fvR4Yvd3wF
7/sHDdO3AQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#32"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRc1EXILSztRC7u5g0cQFDuvYqliYesRUm3AKhAlIAiCRSQS
EpSQI0h2kg+z02wef/bt7Gaw2MyXHaXUUClVr1yV7vFHsDJVgq9RXT/tNDwx
9UV+2NdVaK9hXnLdF74MbHTRB/vZl1q+t3aFL9Fdsf8F3pn+pzX/Azw2/jv6
eYmt/SF4ZPovVu6Dt4bP8Lcv2OYnzkmyT23/jP1gzkOy5gNPeX5q/lWw5vuB
j3x/9Mf8PiTnS5A370uu8KfIb/x/wHxeRo7w5dQXvoI84fvifPb9wOwrLV+F
ef8Kc7b/
          "]]},
        Annotation[#, "Charting`Private`Tag#33"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRZeYEHIMSztRC7u9g0cQFDuvYqliYesRUq1gFYgSEATBIhIJ
CQkhR5DsbD7MTjP7+TNvZ2eHy+1i5QghRkKILlO0akCH61pHo1yj73EXtfKM
nuqo4B8PXZQqMJpSoXzGy6E1Lv7hPuJlFu+L+yilqKf+D/Re17+t+V/gTTT/
qRzGS6CpP0L/WNffLH4IvdP6An6/wd4/ky+5DqHnxJcu8yP4Zj7Zzzej+aE3
9D7oE70f/QntR/L5Uvhmv9Jj/Az+g/4Hmu7LLV4hfcYrZcB4FeqJV1u8RvL/
bfH+P/jktvE=
          "]]},
        Annotation[#, "Charting`Private`Tag#34"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhkO1lT6Go5uog1vewUcQFDdfxVHFwdVH6BTBqVClIAiCQ6VS
WlpKH0GaS3+43JJ83N2XSzJcbhcrRwgxEkK0K0WjerS5rnXUqm/4HrVRgac6
SvDx0EahfMO05MpjvkwNDGtd9MN55Est31e5zJegnvo/4L2uf1vzv+CbaP9T
OcwXg6k/RP9Y198sfwDeab7A371glz9TXnIOwHPyW/kQbOaT3Xwzmh+8ofuB
T3R/9Mf0PpLPlyBv3le6zJ8i/6D/AdN5meXLpcd8hfSZr0Q9+SrLV0v+vw3u
/wfy1Lbt
          "]]},
        Annotation[#, "Charting`Private`Tag#35"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoPaSh/D0U3UwS3v4CMIipuv4qji4OojdErBqVClIAiCQ6VS
WlpKH0GaS3+43HL5uMuXSzJa7ZbrnhBiLIRoM0Wj+rQINjpqNTB8j9qowDMd
Jfh0bKNQnmFKuXKZL1NDw1oX/XAe+VLL91UO8yXop/0fZWYPDrr/bc3/Ak+1
/4l+SrG1P0T/RPffwFT3wXvNV8zbvWDnu1Bd9hn74AX5rXoINvPJzjen+cFb
uh/4TPfH/pjeR/L5EtTN+0qH+VPUH/Q/YDovs3y5dJmvkB7zlegnX2X5asn/
t8H9/+38tuo=
          "]]},
        Annotation[#, "Charting`Private`Tag#36"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhd/cw1LO1ELu72DRxAUO69iqWJh6xGsNmAViBIQBMEiooSE
hJAjSPbbfLA7zeYxM29nJ4PFZr5sCSGGQoj6RFSqjQ9/paMk38I6CtUxPNGR
kw/7OjLlGcaRqp7lS1TfsNaFP/rh+zq+j+pavpj16H8rM7u/0/UvZ/4neaz9
D9bjiJz+gPUjXX8lI38hbzWfOW+zwcZ3Ql62Lb6QZ/A7+YBs5pONb4r5yWu8
j3zE+9kfYT/Sni9m3uxXdi3/l/k7/g8Z9yWOL5U9y5dJz/LlrIevcHyl46v4
/j/o3Lbm
          "]]},
        Annotation[#, "Charting`Private`Tag#37"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb0KwjAUhYO/fQ1HN1EHt7yDjyAobr6Ko4qDq4/glIJToUpBEASHilJa
WkofQZqTHkjukn7cky836WCxmS9bQoihEKJeUZVq48Nf6SrJt7CuQnUMT3Tl
5MO+rkx5hrGkqmf5EtU3rHXhj374vo7vo7qWL2Ye+9/KzO7vdP7lzP8kj7X/
wTyWyNkfMD/S+SsZ/Qt5q/nMeZsXbHwn9GXb4gt5Br/TD8hmPtn4ppifvMb9
yEfcn/sjvI+054vZN+8ru5b/S98d/4d5nJc4vlT2LF8mPcuXMw9f4fhKx1fx
/n/oVLbl
          "]]},
        Annotation[#, "Charting`Private`Tag#38"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRZfEYK5haSdqYbd38AiCYudVLFUsbD1CqhWsAlECgiBYRCIh
EpEcQbJ/82F3mtnHzP87s9ubraZzTwjRF0I0GVErH4fTQsePfEma+KqO4ZGO
irzbNvFRoWGkUgWWX6G6hrVd8lae5Zc7fi/qkTLOA/2T+o3uf5Bx3539Q+1/
Yx0pdfQxeaD7z9SjHpHXmo+ct33BVn9AXfoWR+QJ/KXdH7Nu5mN9jPnJS+xH
3mN/cor3kfZ8Gf3N+8rA8s+pv+J/2I/7CsevpN78vwwtv4r98Ps6fj/Hr+b+
f958tt4=
          "]]},
        Annotation[#, "Charting`Private`Tag#39"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRZfESK5haSdqYbd38AiCYudVLFUsbD1CqhWsAlECgiBYRCIh
EpEcQbJ/82F3mtnHzP87s9ubraZzTwjRF0I0GVErH4fTQsePfEma+KqO4ZGO
irzbNvFRoWGkUgWWX6G6hrVd8lae5Zc7fi/qkTLOA/2T+o3uf5Bx3539Q+1/
Yx0pdfQxeaD7z9SjHpHXmo+ct33BVn9AXfoWR+QJ/KXdH7Nu5mN9jPnJS+xH
3mN/cor3cfwysnlfGVj+OfVX/A/7cV8h7X1L6s3/y9Dyq9gPv6/j93P8as77
B9ucttw=
          "]]},
        Annotation[#, "Charting`Private`Tag#40"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRReTiNewtBO1sNs7eARBsfMqlioWth7BagWrQJSAIAgWkUiI
JIQcQbJ/82F3msljZt7Obvrz9WzREUIMhBBNRtTKfF+WOirlGb5FTZTksY5C
+Yb3uyZ+qmcYKVeB5ctU17DWRV+eB1/q+D6cR0rYj/k3eav7X87+T+470v4H
60ixMx+Sh7r/ynnUz+SN5hO5fcF2/oi69Cw+k6fwS7s/lLYvZn2C/ckr3I98
wP3JMd7H8SWsm/eVgeVPWb/j/3Ae52XSt3w5583/lz3LV7AfvtLxVY6v5r5/
0sS21w==
          "]]},
        Annotation[#, "Charting`Private`Tag#41"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTsKwkAURQeT6Dos7UQt7GYPLkFQ7NyKpYqFrUuwGsEqECUgCIJFJBIi
CSFLkMydXJh5zcvhzjvzSX++ni06QoiBEKLpqFqZ78tSV6U8w7eoqZI81lUo
3/B+19RP9Qyj5SqwfJnqGta66Mv94Evph+/DebSE6zH/Jm/1+pdz/id9I+1/
MEeLnfmQPNTrr05+Jm80n+hvX7DNj8ilZ/GZPIVf2utDafti5hOcn7zC/cgH
3J8c430cX8LcvK8MLH/K/I7/w3nslzm+nPPm/8ue5Sukb/lKx1cxR6vp/wPK
5LbR
          "]]},
        Annotation[#, "Charting`Private`Tag#42"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRdDzDks7UQt7PYOHkFQ7LyKpYqFrUdItYJVIEpAEASLSCRE
EkKOIJnZfNiZZvbzZ97szg4Wm/myp5QaKqXazNEYe76sKGrjWX2L26igJxQl
9GHfxs8EVnMqjO/wctO3mnDxF/OYlwneB/2cUtRz/xt6R/Uvcf8neGPiP+Bz
SkR/BD2i+qvwQ+gt6TP43QY7/8S+9hwd6s6fMV+79ZF2eQn8Kd8fes3vgz7y
+6ET3o/gpfDtfrXv8DP4d/4f9PO8XPAK9Nv/14HDK1HPvErwasFrMP8Pxwy2
zA==
          "]]},
        Annotation[#, "Charting`Private`Tag#43"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhcluYelnaiF3d7BIwiKnVexVLGw9QipVrAKRAkIgmARiYRI
QsgRZGc2H+xMM3l8s29/Mlhs5sueUmqolLKdqzXu+7Kiakzf8S2xVYMnVBX4
sLf1M6FjbqUJPF+BnHTJF/uxLxe+D9ZzyzDP69/gHc2/xPmf8I3J/0DOLRXr
Y/CI5q8ij8Bb4jP83Qt2+Ylz7XMEnrFf5LH2fSnyKZ8fvOb7gY98f3DK7yN8
GXL3vjrw/DnyO/8fsV8hfCXWu/+vQ89XYZ59tfA1wtci/wPCpLbH
          "]]},
        Annotation[#, "Charting`Private`Tag#44"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRldNcg9LO1ELu72DRxAUO69iqWJh6xFSrWAViLIgCIJFJBIS
EkKOINnZfLAzzeTxzb79yXC5Xaz6QoiREKLtVI2y39e1qRp8j9uq1MDy1FQJ
Ph7aKlRgmVqufMeXITe6+Ac/+VLm+yrP8SWYp/Uf8N7Mv9n5X/BNjP+JnJpm
6yPw2MzfWB6Cd4Yv8Hcv2OVnyqXLIXhOfpZH0vVp5DM6v+xZ3tD9kJ/o/mBN
78N8CXL7vtJz/CnyB/0fMO2XMV8ufcdXyMDxlZgnX8V8NfM1yP+8tLbD
          "]]},
        Annotation[#, "Charting`Private`Tag#45"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRVcN3sPSTtTCbu/gEQTFzqtYqljYegSrFawCUQKCIFhEIiGS
EDyCZP/mw840s58/83ZntjdbTedtpVRfKVVnxM+483lho6K+RnWUpuP0yEZB
vdvW8TVdp5FyE3i8jL7FRR/ywUsF781+pIT16H9Rb2z907S8+x7kDS3/znqk
WPSH1ANbfxH+iXpt9ZH8ZoONf4CvfX2inoAv/FD7vJj+GO/XzXxLzEd/j/mp
Y+xH8BL6br868Pgp/Rv+hxr3ZYKXs9/9v+56vIL14JWCVwnej/4fuFy2wA==

          "]]},
        Annotation[#, "Charting`Private`Tag#46"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRVcNuYelnaiF3d7BIwQUO69iqWJh6xFSrWAViBIQBMEiEgmR
hJAjSPZvPuxOM/v4M39ndofBZrHsCyFGQog2IxplzpeVjpp8i9uo1MDwVEdJ
Puzb+CnfMFKhPMsvp67t4i/94Zc5fh/2I6WsR/+bvNP1L9Wz7ntSn2j/Bxkp
cfoj8ljXXx09JG81nzlv94KdfoIubQ7Jc/g7eiRtv4T6DPPLbr819qN+xP7k
BO8j7X1Tsnlf6Vn+GfU7/oeM+3JnvoL95v+lb/mVrIdf5fjVjl/Def+17La+

          "]]},
        Annotation[#, "Charting`Private`Tag#47"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSrWAViBIQBMEiooRI
QsgRJDubDzPTzD7+zN+Z3f58PVt0lFIDpVSTKWrjzueljQp8jZsoTdfx2EYB
3u+a+JnAMaXc+MwvMz3H1i7+wp/8PsLvjX5KKeqp/wXe2vqn8dh9D+gj638H
U0pEfwQe2vqL0EPwxvIJ87Yv2OpH0jXnEDwlf+0xPdLcL0H9hOZH/Yr2g36g
/cEJvY/m+6Zg977aZ/4f6Df6HzDdl4n5cvS7/9cB8yuEXyn8KuFXY94/snS2
uw==
          "]]},
        Annotation[#, "Charting`Private`Tag#48"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSrWAViBIQBMEiooRI
QsgRJPs3H3anmX38mb8zu/35erboCCEGQogmI2plzueljop8jZsoVdfwWEdB
3u+a+KnAMFKufMsvUz3D2i7+0h9+H8fvzX6klPXofynP8FbXP8m478H6kfa/
U0dKnP6I9UNdfyFDD8kbzSfO275gqx+hS5tD8hT+0rP0iLqZj/oE85NX2I/1
B+xPPcH7OH4p2byv9C3/D/Ub/oeM+zJp75uz3/y/DCy/wvErHb/K8as57x+q
lLa1
          "]]},
        Annotation[#, "Charting`Private`Tag#49"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSrWAViBIQBMEiooRI
QsgRJDObD7PTzD7+zN+Z3f58PVt0lFIDpVSTOWpjz+clRQW+xk2U4DFFAd7v
mviZwDKn3PjCLzM9y2QXf40n/D6mK/ze6OeUop77X+At1T/BfN8D843I/w6d
U+L0R6gfUv0FzHoI3hCfMG/7gq1+ZF1LDsFT9tee0CPodj7oE54fvOL9wAfe
H5zw+zh+KXT7vtoX/h/U3/h/wHxfpuW+Ofrt/+tA+BWOX+n4VY5fjXn/oFS2
rw==
          "]]},
        Annotation[#, "Charting`Private`Tag#50"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSbcAqECUgCIJFJBIi
EckRJPs3H3anmX38mb+zs/35erboCCEGQogmI2rl4RAtdfyU0aJL0sSXPNZR
kfe7Jj4qMIxUKt/yK1TPsLZL3rwPfrnqWn4v9iNlrEf/k7zV9Q9n/jvnG2n/
G3Wk1OmPyUNdf2Y/9JC80XzivO0GW/0IXdockqfwl56lx9TNfNQnmJ+8wvvI
B7yfnGI/jl9G3exX+pZ/zvor/oeM+wrHr2S/+X8ZWH6V4/d1/H7S3l9N/z+b
3Las
          "]]},
        Annotation[#, "Charting`Private`Tag#51"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRdeYHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYSE
hJAjSPYnH3anmX38mb+zs6PVbrl2hBBjIUSbEY0a4BBsdNSq04J71EZFnuko
yadjG4XyOkbK1dDwy6hru+jH++CXsh5+X+Uafgnr0f8hH3T925r/xfmm2v9J
HSm2+kPyRNff2A/dJ+81Xzlvv8G+/wJdOgb75AX8pVkfUu/moz7H/OQt3kc+
4/3kGPux/BLq3X6la/inrH/gf8i4L7P8cmn+VyE9w6+0/Cpr/trya8h/lTS2
pQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#52"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRdeYHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYSE
hJAjSPYnH3anmf38mbezs6PVbrl2hBBjIUSbEY0a4BBsdNSq84J71EZFPdNR
Up+ObRTK6zRSroYGL6OvcdGP94GXsh68r3INXsJ69H+oD7r+bc3/4nxTzX/S
R4qt/pB6outv7IfvU++1vnLefoN9/wW+dAztUy/Al2Z9SL+bj/4c81Nv8T7q
M95PHWM/Fi+h3+1XugY/pf/A/1j3ZRYvl+Z/FdIzeCXrwassXm3xGuo/lDS2
ow==
          "]]},
        Annotation[#, "Charting`Private`Tag#53"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAURNeEHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYSE
hJAjSHbWgd3f/Dxm/uzfzXC5Xaw8IcRICNF3VKcG+IjWulpltOiW9NWQp7pq
8vHQV6UCw2il8q28grqOS748D3k5/cj7kNEy+jH/Ju+1/+Xs/+R+E53/oI6W
OvMxeaz9V85DD8k7zRdnPyH+82fo0rM4JM+RL21/TN3sR32G/ckb3I98wv3J
Kd7Hycuom/eVvpWfU7/j/zjnFU5eKe3/VcnAyqvpR17j5LVOXkf+AZGktqE=

          "]]},
        Annotation[#, "Charting`Private`Tag#54"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRdeEHMTSTtTCbu/gEQTFzqtYqljYeoRUCVgJUQKCIFhEIiGS
EHIEyf71w840s58/82Z2tz9fzxaeUmqglOoyoo16OMRLE01kvfiadFFTj01U
1PtdF98osBqpjHyHV9A3uOTDeeDlgvdmP1LGevS/qLem/in2f1CPDP9OjZSK
/gv10NSfuQ/8kP7G6JPYT6m/f4SvPUeH1FPwtVt/oW/3oz/B/tQr3I/6gPtT
p3gfwcvo2/fVvsPP6d/wP2JeIXgl++3/68DhVawHrxa8RvBa+j+MdLad
          "]]},
        Annotation[#, "Charting`Private`Tag#55"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRdeEHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYRI
QsgRJPs3H3anmf38mbezs8PldrHyhBAjIUSXEa0a4BCtdTTKeNEt6aKmnuqo
qI+HLn4qMBqpVL7FK+hrXPLlfeDlDu/DfqSM9eh/U+91/cuZ/0k90fwHNVLq
9MfUY11/5TzwQ/o7rS/0+w32/hm+9CwdUs/Bl3Z9LG1eSn+G+ak3eB/1Ce+n
TrEfh5fRN/uVvsXP6d/xP859hcMr2W/+XwYWr2I9eLXDaxxeS/8Pixy2nA==

          "]]},
        Annotation[#, "Charting`Private`Tag#56"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRdckF7G0E7Ww2zt4BEGx8yqWKha2HiHVBqwCUQKCIFhEIiGS
EHIEyf7Nh91pZj9/5s3s7nC5Xaw8IcRICNFlRKsGOERrHY0yXnRLuqippzoq
6uOhi58KjEYqlW/xCvoal3w5D7zc4X3Yj5SxHv1v6r2ufzn7P6knmv+gRkqd
/ph6rOuv3Ad+SH+n9YV+/4K9f4YvPUuHsvfn4Eu7PpY2L6U/w/7SjIk2uB/9
E+5PneJ9HF5G37yv9C1+Tv+O/6HGvMLhlew3/y8Di1c5vNrhNQ6vpf8HhBy2
lg==
          "]]},
        Annotation[#, "Charting`Private`Tag#57"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhVeTi1jaiVrY7R08gqDYeRVLFQtbj5BqA1ZClIAgCBaRSIgk
hBxBsi95sDPN5PHtfNmfwWIzX/aVUkOlVNNRtenhI1zZqkzLwlvUVEk+sVWQ
H/ZN/YzfZrTceI4vI7e66Ct8qfB9OI+WcD3m38w7u/4l9v9kHlv/gxktNsqZ
v5KP7PoL9wMekG9tPpN3N9jxE7h2c8A8g1/wq3Z9se72N8X+mdc4H+ePOD9z
jPsRvoS8vV/tOf6U/I73Ycb/MuHLOd++v/YdXyF8pfBVwleT/wF97LaS
          "]]},
        Annotation[#, "Charting`Private`Tag#58"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhqP1Io5uog5uuYNHEBQ3r+Ko4uDqETql4FSoUhAEwaFSKZWW
0iNI86c/9L3l9edLvr4kw+V2seorpUZKqaajatPDR7C2VRnHglvUVEk+tVWQ
Hw9N/YznMlpODl9mBi5bXfQVvlT4PsKXcD32v5n3dv1LzP9knlj/gxktNqqz
PyQf2/VXzgPuk+9svpC3N9jyM7juZp95Dr/goe76Yt3ON8P8zBucj/tPOD9z
jPsRvoTc3a/2Ov6U/I73Ycb/MuHLtXh/4SuErxS+Svhq8j94zLaO
          "]]},
        Annotation[#, "Charting`Private`Tag#59"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAUhqP1Io5uog5uuYNHEBQ3r+Ko4uDqETql4FSoUhAEwaFSKZWW
0iNI86c/9L0l/fjzvr4kw+V2seorpUZKqWZF1aaHj2BtqyLfoqZK8tRWYVxv
cDw09TOeYyw5c/gyM3BsddFX+FLh+whfwv3ofxs3eLC3+19i/id5Yv0PMpZY
9IfMx3b/lYzcJ+8sXzhve4Ntfkauu+yT5/CLPNRdX6zb+WaYn7zB+dh/wvnJ
Me5H+BLm7n611/GnzO94HzL+lwlfrsX7C18hfKXwVcJXM/8DcwS2iw==
          "]]},
        Annotation[#, "Charting`Private`Tag#60"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRUdzEks7UQu7vYNHEBQ7r2KpYmHrEVJtwCqgEhAEwSISCZGE
kCNI9icfMtNMPn/m5e/uYLGZL/siMhSRuqMq28NHsHJVUt+udRXUE1e5bXaD
w76un/UajZbRBy+l73DXr+IlivehRos5j/23bYIHOzf/Uvmf1GPHf1CjRWo/
pD9y8xdq+D711umzyifS+if4pqt96hn4yg9NlxeZNt8U+anXOB/3jzg/dYT7
UbyYfnO/9MFPyL/jfTiP/6WKlxn1/sbr8HLug1coXql4Ff0/bcS2hw==
          "]]},
        Annotation[#, "Charting`Private`Tag#61"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRUdzEks7UQu7vYNHEBQ7r2KpYmHrEVIlYBWIEhAEwSISCZGE
kCNI9q8fMtNMPv/Py+zuYLGZL/siMhSRtqOaoIePcGWrpr7GbVXUE1tl4GbD
w76tb+A5jVbQBy+nb3HxR/EyxXtTo6XMY/4VuMXDnc0/1f4P6rHl36nREjUf
0R/Z/IUavk+9tfqs9hP5+yf4pqt96hn4Rjp+ZLq8hP4U+1OvcT7yjjg//QT3
o3gp8+5+6YOfcf6G92Ee/8sVrzDq/Y3X4ZWcB69SvFrxGvo/a+S2hQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#62"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdUTEKwkAQXM1LLO1ELezuDz5BUOz8iqWKha1PSHUBq4BKQBAECyUSIgkh
T5DcxIHbbfaGmZ2b2+vNVtN5V0T6ItJ0VG07OEQLVxXx5dxUSTxyVdh2Ntpt
m/raoMVoOXn4ZeSd3fljxfNLld+bGO3F+zH/5PzG6R8q/5146PxvxGiJmo+J
B05/oh58SLx2+Kjyifz5A3jj45B4An8jHh8blY/8GPmJl3gf9Xu8n3yC/Ri1
P+rb/ZKHf8r5K/6HetyXqXy5Uf9vAs+voB5+pfKrVL6a/j9m1LaB
          "]]},
        Annotation[#, "Charting`Private`Tag#63"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwlAQRFdvYmknamH37+ARBMXOq1iqWNh6hFQJWAWiBARBsFAiISEh
5AiSnTiQ3WYzzOz7+38Gi8182ReRoYg0HVX7PXwEK62K+ho1VVJPtAq/nQ0O
+6ZyarTM8FL6iou+vnR4ieF9DO9NHuZfnN9p/mnOe1CPlX+nRovNfEg90vyF
efge9Vb12ewn8vdP8F1Xe9Qz8J10/NCZ/ehPsT/1Gvdj/oj704/xPs68H/Pt
+9IHP+H8Df+HeZyXmv0yw8sNr6APXml4ldmvJv8HX4y2fA==
          "]]},
        Annotation[#, "Charting`Private`Tag#64"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwlAQRFdvYmknamH37+ARBMXOq1iqWNh6hFQJWAWiBARBsFAiISEh
5AiSnTiQ3WYzzOz7+38Gi8182ReRoYg0HVX7PXwEK62K+ho1VVJPtAq/nQ0O
+6ZyarTM8FL6iou+vnR4ieF9DO9NHuZfnN9p/mnOe1CPlX+nRovNfEg90vyF
efge9Vb12ewn8vdP8F1Xe9Qz8J10/NCZ/ehPsT/1Gvdj/oj704/xPs68H/Pt
+9IHP+H8Df+HeZyXmv0yw8sNrzC80uxfmf1q8n9fLLZ6
          "]]},
        Annotation[#, "Charting`Private`Tag#65"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRcfcxNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsIhEQkJC
yBEk++OHnWkmn//n7exmuNwuVp6IjESk66g2GOAjXNtqqG9xVzX11FYV9LPh
8dBVSR+tULyceYuLv4E4vEzxPtRoKXmYf3N+b/Mvdd6TemL5D+bREjUfUY9t
/sp5+D71zuqL2k/k75/hG1f71HPwjTh+ZNz3S+jPsD/1Bvdj/oT700/wPoqX
UvfvazyHn3H+jv/DPM7LFa9QvJIavErxarV/o3gt/R9aHLZ0
          "]]},
        Annotation[#, "Charting`Private`Tag#66"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRUdvYmknamG3d/AIgmLnVSxVLGw9QqoErAJRAoIgWCREQkJC
yBEk++OHnWlmP3/mzezuaLVbrociMhaRLiNavz8EGxuNP+j1Peqipp7ZqKhP
xy5KaqSCGrzc72cFFhd9OQ+8jD54KTVSQh76P+w/2Pq3mveinlr+k/VIseoP
qSe2/sZ++B79vdVXtZ/Iv/4C37jao16Ab8TxQ+O+X0x/jv2pt7gf68+4P/0Y
76N4iXH/KzVDh5+x/4H/YT3m5YpXKF5JDV6leLXav1G8lv4PU9S2cQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#67"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRTfexNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsEiIhISE
kCNI5ocPO9PMfv7Mm9nd8Xq/2oyMMRNjTJ8RXTAcwq1EG3iDfsR9NNRziZr6
fOqjokYqqcErgmFWKLj4x3ng5fTBy6iRUvLQ/2X/Ueo/at6beib8F+uREtUf
UU+l/s5++D79g+ib2o8RXuFbz9E+9RJ869ZH1n2/hP4C+1PvcD/WX3B/+gne
R/FS6/5XZkcOP2f/E//DeswrFK9UvIoavFrxGrV/q3gd/T9SjLZw
          "]]},
        Annotation[#, "Charting`Private`Tag#68"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRTfexNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsEiIhISE
kCNI5ocPO9NMHjPzZjc7Xu9Xm5ExZmKM6TOiC4aPcCvRBt7Aj7iPhjyXqMnn
Ux8VGakkw1cEw65QdPGP++DLWYcvIyOl9GH+y/mj9H/Uvjd5Jv4X+5ESNR+R
p9J/5zzqPusH4Zu6LyO8om49h33yEn7r9kfW9SWsL3B+8g73I19wf3KC/6N8
qXXfK7Mjx59z/on3YT/2FcpXKl9Fhq9Wvkadv1W+jvU/UFy2bg==
          "]]},
        Annotation[#, "Charting`Private`Tag#69"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRTfexNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsEiIhISE
kCNI5ocPO9NMHjPzZjc7Xu9Xm5ExZmKM6TOiC4aPcCvRBt7Aj7iPhjyXqMnn
Ux8VGakkw1cEw65QdPGP++DLWYcvIyOl9GH+y/mj9H/Uvjd5Jv4X+5ESNR+R
p9J/5zzqPusH4Zu6LyO8om49h33yEn7r9kfW9SWsL3B+8g73I19wf3KC/6N8
qXXfK7Mjx59z/on3YT/2FcpXKl9Fhq9Wvkadv1W+jvU/UFy2bg==
          "]]},
        Annotation[#, "Charting`Private`Tag#70"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRTe5iaWdqIXd3sEjCIqdV7FUsbD1CKkSsApECQiCYJEQCYaE
kCNI5ocPO9NMHjPzZjc7Wu2Wa98YMzbG9BnRhcNHtJFoQ2/ge9JHQ55J1OTT
sY+KjPQjw1eSRZd8uQ++IvQdX05GytT8h/MH6X+rfS/yVPxP9iOlaj4mT6T/
xnnUA9b3wld1X0Z0Qd16DgfkBfzW7Y+t60tZn+P85C3uRz7j/uQU/0f5Muu+
V259x19w/oH3YT/2lawP76t8FRm+Wvkadf5Wna+j/w9NzLZs
          "]]},
        Annotation[#, "Charting`Private`Tag#71"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRSe5iaWdqIXd3sEjCIqdV7FUsbD1CKkSsArEsCAIgkUkEgwJ
IUeQnQkfdqbZ/fw/b2d3R6vdch0S0ZiI3CrVx8Mm2XB10PfMVRsHg55xNdCn
o6saeVl+8IVXQTMu+yIvvFLxPnHo8QrV/0b/gfMvdd4Tesr8h5rPqv4UesL5
G/rFj+DvWV/hk1/JRXwTeDqCXgjf+PnU+DwLfy7zQ2/lftBnuT+0lfdRvMKo
9zWhxy/Rn8v/IC/nVfCH/1W8Ws3bKF6r5u/UfD34f0a8tmg=
          "]]},
        Annotation[#, "Charting`Private`Tag#72"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAYhdPexNFN1MEtd/AIguLmVRxVHFw9QqcUnApVCoIgOFQqxdJS
egOleeFB/rekj/fy9U8yWGzmy1ApNVRK9SvUGfcRr6xa+mvaqzGB8xOrmv6w
71Wxj+XLHLyS3uLSD/vgFYL3NqHHy8X+l/lBZmf7TzH/g/2x5d/FfBk99if0
I9u/cD/yiPnW+jNz5Ss+IdeB5yP6Gfja7yfa52XMp5iffo3z0R9xfvoM9yN4
uRb3q0OPX3D/De/DPv5XMnfvK3iVmLcWvEbM34r5OvL/ChO9Xw==
          "]]},
        Annotation[#, "Charting`Private`Tag#73"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAYhdPexNFN1MEtd/AIguLmVRxVHFw9QqcUnApVCoIgOFQqpdJS
egOleeFB/rekr+/l6590sNjMl6FSaqiU6leoM+4hXlm19Ne0V2MC5ydWNf1h
3+vLPpaKOXglvcWlH/bBKwTvbUKPl7OP/S/zg8zO9p9i/gd5Y8u/s4/XGfvY
n9CPbP8i8oh+a/2ZfOUrPiHXgecj+hn42u8n2udlzKeYn36N89EfcX76DPcj
eDlzd7869PgF8xv+D/fje6X276/S4v+LeWvBa8T8rZivY/4HPJXLTA==
          "]]},
        Annotation[#, "Charting`Private`Tag#74"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAYhdPexNFN1MEtd/AIguLmVRxVHFw9QqcUnAq1FARBcFAqpdJS
egOleeFB/rekX/+Xlz9/BovNfBkqpYZKqX6FOuM+4pVVS76mvRoTOJ5Y1eTD
vteXfiwV68gryTYu/dCPvELkvU3o5b3ox/6n+UFmZ/0P0f+deWObf6Mfv3P6
sT8hj6z/IuoReWv5zHzlKz6hrgOPI/IM+dr3J9rPy1mfon/yGvcjH3F/co75
kN38yG6+OvTyC9YzvA/7wXml9udXafH+ot9a5DWi/1bct2O/fzvdy0s=
          "]]},
        Annotation[#, "Charting`Private`Tag#75"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRdfcxNJO1MJu7+ARBMXOq1iqWNh6hFQbsApECQiCYKFEQkJC
yAmM7Mz6Yec3m7/z9+3spD9fzxaBUmqglLIrqzXuI1qSGvhLYlWbnvNjUgW/
31mVyPNSCF6OPOGSD+rMywTvbQKP90Kezz/NtyOZLeUf4r47eCPi30zn8ryd
Is/nY/gh5c+iHsJvyJ/AV76iI9e170P9z0+ZL+qx9nkp6hPuH37F74M/8Pvh
U54PvJsfvJuvDjx+hvqV/4+4L9f+/ArBK0W/leDVgteI/lr4HzWty0U=
          "]]},
        Annotation[#, "Charting`Private`Tag#76"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRdfcxNJO1MJu7+ARBMXOq1iqWNh6hFQrWAWiBARBsFAiISEh
5AQq2b9+2Jlm+fl/385MutPlZBYopXpKqfZENeaLMnNbtXHG8Ry3VZmO00Nb
JfV201bBPI6cGryMeYuL3/TBSwXvZQKP92Qe9x/m4/pd2/xdvHcjb2D5V86H
zwnzuB9R923+JPyQemX1gXzl13EPX/s61P/8GHzhR9rnJfRH6J96gfn0f54d
5qefYD/Ubn/Ubr868Pgp/Qv+j3gv0/7+csEr6INXCl4leLXor6H+AXM44C0=

          "]]},
        Annotation[#, "Charting`Private`Tag#77"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdUTsKwkAUXL2JpZ2ohd3ewSMIip1XsVSxsPUIqTZgFYgSEATBQokEQ0LI
CVSysxnYN80yO+/N+/Vmq+m8q5TqK6WaF6jNDzALi8o4ITzHDUrTcXxkUVDf
bRvkzMf3hzr8MuZbu/hNHX4pdfi9jOstxPNkPPIf5uvqbWz8XdS7kQ+t/1X0
l1BHfkQ+sPEnoQfka8uP7Ff5CA/Qtc8D3cZP4C/0SPt+CfUx+idfYj7dzrPH
/NQT7Ifc7Y/c7Vd3Pf+U+gX3EfUyLe4r/HLd3gN+hfArhV8l+qvJ/0Cs5yI=

          "]]},
        Annotation[#, "Charting`Private`Tag#78"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdUTsKwkAUXHMTSztRC7u9g0cQFDuvYqliYesRUm3AKhAlIAiChaKESELI
CVSysxnYN80yb96b99nudDmZBUqpnlKqeYHa/AAzt6iME6JT0qAkH1oU5NtN
g4/5unqEc+rwy0zHcWuXvIXfizr8nsbNFuF5MB/1d/Zb2/yb6HclH1j/C/dD
OKWO+pi8b/OPQg/JV5YfOK/yEe2ha5+Hus0fw1/osfb9UuojzE++wH663WeH
/amnuA+5ux+5u68OPP8X9TP+R/TLtH+/XPh9dPsf8CuEXyn8KjFfTf4HO/zn
IA==
          "]]},
        Annotation[#, "Charting`Private`Tag#79"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAYhVNv4ugm6uCWO3gEQXHzKo4qDq4ewSkFp0KVgiAIDkqltLSU
nkClefFB/reEL+/PS/4/3elyMusopXpKqXaFGvOFzNyqNs4Iz3Grijy0Ksnb
TavCfNx5bOf0kZeZwLGNi98iL6WPvJdxbwuxPFmP8w/et7b1d3HfjTyw+Vf2
h+2EPs5H5L6tPwn/SF5ZPpCVr3APX/t8JI+RL/xIB15eQn+E95MX6E//+9mh
f3KC+bDezY/s5qs7Xn5K/4L/Efdl2p9fLvIK/f8P5JUirxJ5tXhfQ/4BlqPu
Fg==
          "]]},
        Annotation[#, "Charting`Private`Tag#80"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb0KwjAUhdO+iaObqINb3sFHEBQ3X8VRxcHVR3BKwalQpSAIgoOiFIul
9AX8oTnpgdyzhC/n3pObpDWaDcehUqqtlKpXqDI/yEysSuOM6JDUKsg9qzd5
tayVm4/rx/aLPvIyso1LniLvYQIv727cbBGWm+i/mq87b2HrL+K8M7lr80+8
H7ZT+uiPyR1bvxf+jjy3vCUrX9EGvvZ5Rx4gXzfzwI914OWlrO9jfvIU92P/
Gvcnp3gf1rv3I7v31aGX/6B/xP+I8zL99f9X5OW6+X/kvUVeIfJKMV9F/gMc
V/UK
          "]]},
        Annotation[#, "Charting`Private`Tag#81"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwjAYhaM3cXQTdXDLHTyCoLh5FUcVB1eP0CkFp4JKQRAEB0UplpbS
C1ileemD/G8JX17+lz/5O5PFeNpWSnWVUvUKleYHmZlVYZwRno61cvLAKiNv
1rVS83X12P7QR15CtnHHt8h7mZaX9zSutxDLQ9TfTeXuW9nzN3Hfldy3+Re+
D9sxfdRH5J49fxB+QF5a3pOVr3AHX/sckEfI100/8CPt58XkIfrn+TneR97i
/eQY/yPyHmT3v7rt5b/onzEfMu5LdOXPV+Slupk/8jKRl4u8QvRXkv9XhfwB

          "]]},
        Annotation[#, "Charting`Private`Tag#82"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkU0KwjAQhWNv4tKdqAt3uYNHEBR3XsWligu3HqGrFFwVqgQEQXBRqRSl
pfQC/tC89EEym/DlzbyZZLrT5WQWCCF6QojmRNTqh1BzE5WyQnRKmijJQxMF
ebtp4q0+th7XL+rwy8nGLnl6fpnqOH4PZWeLcKScD/V39bW8Nvk3r9+VPDD+
F9bjWlNHfUy9b/KPnh6SV4YPZOFGtIcuXQ7JY/jLth/0WLp+mjzC/Mxf4H2y
ff8O76eu8T+eX0rd/q8MHP+M+Wfsh4x+OfvZ/VK3+5ft/uFXeH6l51d589Xk
P6DlEPc=
          "]]},
        Annotation[#, "Charting`Private`Tag#83"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAViCAiCYBGJBENC
yAH8I/s2D3Zfs3w7M29mdnuz1XTeFUL0hRDNCdXqB6mFVqVMwD+HjUrySKsg
77aNcvUx9bh+OX4Z87Vd+HT8UtWx/B7KzObjSOiH+rv6Gt7o/Bv90O9KHmr/
C+txHZNRH5AHOv/EesQ98lrzkSxs+QfEpc0eeQJ/2fZDPJC2X8z4GPOTl9hP
tvvvsT/jMd7H8UsYN+8r2/eFf8r8CP9DRr+M/cz/On65fFvzFo5f6fhVznw1
+Q8GKSzW
          "]]},
        Annotation[#, "Charting`Private`Tag#84"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkj8KwjAYxaM3cXQTdXDLHTyCoLh5FUcVB1eP0CkFp0KVgiAIDpVKsbQU
D1BUmpc8SN4Sfnn5Xr786c1W03lXCNEXQrQj9FE/SC20amWM8By3qsgjrZK8
27YqVGPqMf328nKyjotfXl7m5T1VxzCG1Kt/qK/hjV5/Zz32u5GHOv/Kekwn
ZNRH5IFef2I9/IC81nwkC1fhAb50OSBPkC9t//Aj6eYl0vYzRv/kJc7H+j3O
Tz/B/Xh5KX1zv9LeL/Izrr/gfcjYL+d+5n29vEI2Tr8lfeRVXl5N3/w/9vsH
9LVBuQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#85"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkj8KwjAYxaM3cXQTdXDLHTyCoLh5FUcVB1eP0CkFp0KVgiAIDpVKUVqK
B6h/SF76IHlLeXn5ft+XpJ3JYjxtCyG6Qgj9hd7qB6mZUaVsEB5jrZJ+YFTQ
b9ZaL1Xbeiw/1dfh5eQbXPygBy/zeHfVsh6f1Ku/kb8y+6+sR78Lfd/wz6zH
ckKP+oi+Z/YfvDygXxq/J1+4CnfIpesD+hH4spkfeSRdXiKbfkPMTz/H+Vi/
xfmZJ7gfj5cyt/crm/sFP+P+E96HHv1y+XHfl/3t+8vambdgP/BKj1cxt/8f
5/0DVV5Wng==
          "]]},
        Annotation[#, "Charting`Private`Tag#86"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkjsKwkAQhldvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgpIQ
PEB8sPtvftidZvkyM9/sI53JYjxtCyG6Qgi9It7qh1AzE5WyifAY6yjJAxMF
6zdrHS9VW0bZU30dX856o4sfZPgy+uG7q5ZlLKnXf6N/Zeqv7Me8C7lv/Gf2
43NCRn9E7pn6g5cPyEvDe/qFG+EOeelyQB7BL5v9Ix9J15fIZt4Q+yfPcT72
b3F+5hPcj+dLmbf3K5v7hT9j/Qnv483L5cd9X8637y9rZ78F++ErPV9Ftv8f
+Q/q+nJ+
          "]]},
        Annotation[#, "Charting`Private`Tag#87"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgiEh
pPeX7Ns82H3N8u3MvJnZ7UwW42lbCNEVQtQnVKkfpGZaJfkY1iqUSfQHWjnj
m3WtTL0NI+2pvpZfStZ24YP18EvoD7+7ahnGETv1N/JK519Zj34Xcl/7n9kP
1xEZ9QG5p/MPTtwjLzXv6S9s+TvEpc0eeQR/2cyPeCCd+chDzE+eYz/5MbzF
/oxHeB9pzxezn3lf2bwv/BPWn/A/Tr+U/cz/On6ZfFnz5o5f4fiVzr4V+Q+/
2odh
          "]]},
        Annotation[#, "Charting`Private`Tag#88"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgpIQ
0sc/sm/zYPc1y9uZ+WZmtzNZjKdtIURXCFGfUKl+kJppFfTHsFauTKI/0MoY
36xrvVRlPNKe6mPxUvU1XuPCB+vBS8gH765axuOInfob+Sudf3Xmv5DX1/wz
47iO6FEf0Pd0/sGJe/RL7ffkC1v+DnFpe49+BL5s9kE8kM589EPMTz/HfrLZ
f4v9GY/wPtKeL2Y/876yeV/wE9af8D9Ov1S+7f9lf/P/srLmzRxe7vAKZ9+S
/g8OYY5U
          "]]},
        Annotation[#, "Charting`Private`Tag#89"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgpIQ
0sc/sm/zYPc1y8fMvPnZzmQxnraFEF0hRP1CpfpBaqZVkI9hrVyZRH+glTG+
Wdd6qcow0p7qY/mlZG0XPlgPv4T+8LurlmE8sfpa9Tf6rXT+1Zn/Qu5r/zMZ
fhEZ9QG5p/MPTtwjLzXvOa+w5e8QlzZ75BH8ZbMP4oF05iMPMT95jv1ks/8W
+zMe4T7Sni9mP3Nf2dwX/gnrT/gfp18q3/b/sr/5f1lZ82aOX+74Fc6+JfkP
8jqVSw==
          "]]},
        Annotation[#, "Charting`Private`Tag#90"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb0KwjAUhaNv4ugm6uCWd/ARBMXNV3FUcXD1EZwiOBWqFARBcKhUSqWl
dG/9oTnJgfQu4eOee3Ju0pksxtO2EKIrhKhPVKF+KDXTlZPPfl2ZMsLjQFfK
/mZd11uVhiFLVOX4xepjWNv5L87DL6I//J6qZRhHqL7O/IN+K62/s4/7bvTv
a/8rGX4BGfMe53tafyKjfyAvNe+Z176g9duhL20ffCCP4C+/jt6TjXzkIfJT
P8d+0u6/xf7UB3gf6eYLOW/eV9r3hX/E+Qv+h4z7Ylk5+RKy+X9ZOnnThl/W
yJ839i3If8HNnDs=
          "]]},
        Annotation[#, "Charting`Private`Tag#91"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdUbsKAjEQjP6JpZ2ohd3+g58gKHb+iqWKha2fYBXB6kBFEATBQjk5FI/D
2tfJZZKBZJswzOzs7KbSGbS7ZaVUVSlVvKin/uWmdM9UpnOLN+uiUm2Fy4ap
B/nJuKi7flsM2U1/PL+E2Nitr+yHXxz4XXTJzsNzZj70n/TX4pHRH4P8B/rV
jf+ePPx25NEfka8Z/YoY/IJ4aPCc93AXdH4z8OJ44IU4vgV/+Xn6iLzNR9xE
fur72E/c/lPsT/0O9xE/35n99r7i7gv/mPwW/0M/zEsk+F/5eH53eXl5H4Ff
GuTPgn2fxH/IB6ok
          "]]},
        Annotation[#, "Charting`Private`Tag#92"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamE3d/AIgmLnVSxVLGw9QqoVrAIqAUEQLBRFFEVS
x5hI9u0+2EyzPN7sN3+13qjbryql6kqp4kXEOstN6IGJj86t3m6KeGubuGqZ
eDF/Ni3iqROrkfbQqce7Uxvc5kY+eFdq8C66YuvhObMe/p/0z+qJyT+W+j+Q
1zT8PX3wImr8D6kbJn9d8gPqsdFL7sNt0NVbwBfnQwfi/A74knn5IX3bH/02
+qceYj5x888xP/9H2I/4/Z3Fv9dF3H7Bv9Lf4T7kod5dvv59JfV4T0m8fl8l
3pv9gvcpzRtT/wHAr6of
          "]]},
        Annotation[#, "Charting`Private`Tag#93"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KAjEQhQdvYmknamE3d/AIgmLnVSxVLGw9glUEqwUVQRAEC5cVURSx
9mdXNi/7IJkmPF7yzZtMud1vdUoiUhGR/ES9TJrZMl1bT5M5vV7l9aCu27rz
/niU1828nQbvar4e70JtcatzwEuowYsdRxY4TuyH90fzc3po7x+C/Hvyapa/
ow/elhrvI+qqvb8M/Dn1wOpZkE+k6DeFr76eUzfB19TzI/ouH/0G8lP3MJ8W
808wP/0t/keD/1N/XzF98BP6G+yHedDvoh9/v/r1eDd9e3nvAe/BvOA91d/H
i/P/AdfuuAs=
          "]]},
        Annotation[#, "Charting`Private`Tag#94"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KAjEQhQdvYmknamGXO3gEQbHzKpYqFrYewSqClaAiCIJgscvKoiiy
taw/7Lzsg2Sa8HiZL28y1e6w06uISE1EihOV2e9Py/a1XtS7bVFP+3O6qfWg
P50Udbdvp8G72dzjpdSK217ZD15CPnix48gKR8T76L/Yj9NjvX8O8p/Iayj/
SB+8AzX6N9R1vb8O/CX1SPUiyCdSvjeHb3y9pG6Db76ev6Hv8tFvIT/1APOZ
cv4Z5qd/wP8EvMj4+4pNmR/8hP4e+2E/3ktNsF+Te7w7ffAeAe/JvOC9jL+P
jHn/wJ2/AA==
          "]]},
        Annotation[#, "Charting`Private`Tag#95"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KAjEQhQdvYmknamE3d/AIgmLnVSxVLGw9glUEK0FlQRAEC2VlURSx
9F/ZvOyDZJrweJkvbzL5ervWyIlIQUTSE3Uz358t07R1pV7M07qYn9NlW2f6
/V5aJ/NwGryjeXu8xLyctrj5gf3gxeSDt3ccmeDY8T76t+bjdNfe3wT51+SV
LH9FH7yIGv0z6qK9Pw38MXXH6lGQTyR7bwhffT2mroKvX8+f0Xf56FeQn7qF
+TSbf4D5qSP8T8Dbqb+vvWb5wY/pL7Ef9uO9RJ/+fvXt8U569/KeA96F+cC7
qr+PG/P+AbrVvvs=
          "]]},
        Annotation[#, "Charting`Private`Tag#96"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KAkEMhYM3sbQTtbDLHTyCoNh5FUsVC1uPsNUIVoKKIAiChaKIsotY
Lv6z82YfzKQZHkm+vEyKzW6jVRCRkohkL+Jhvj8bpm3jTr1cZJGYn9NVGzHz
w0EWN5M6Dd7VvD3exbyctrjFmf3gncgH7+g4MsVzYD369+bjdN/W7wL/W/Iq
lr9hHrw1Nfrn1GVbPwvyEXXP6kngTySfN0ZefR1p3l8HXz9efq6BP+oa/LO+
g/00/98R9md+jf/hfPd/6t/rqLl/8E/sX+E+rMe8iz79+3K+u7+mnt+Y/eAl
gf97sO+Dfv+yhb7z
          "]]},
        Annotation[#, "Charting`Private`Tag#97"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uB27+AjCIqbr+Ko4uDqI3SK4FRQKQiC4KBUiqWl
dCzWWmku+SG5JXzc3ZfLpT2ejyYtIURHCNGcHLn81SrkVEUGPh2bSMF9FYms
NK9XTcSy0My+tywtXwRWuuPL8YWytnxP7RF7Ph6o5/477l+q+psz/xW+nvJf
kGdfAOZ+H9xV9Qcn74EXinfwmw0a3nKebPbI9A/ZT5WV98mZDzzg+VE/4/fR
V/OG3498wPvB/Xp/8On9ktkv+0P0n/l/UM/3RfSx/5dKyxdTYc2boJ99qTN/
5rw3x7x/9BjF5w==
          "]]},
        Annotation[#, "Charting`Private`Tag#98"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTsKAjEURYM7sbQTtbB7e3AJgmLnVixVLGxdglUEK0FlQBAEC0WRGWYQ
Sxm/TG5yIXlNOLzkvE/K7X6rU1JKVZRSxYl46O/PhO6auJM36yIyct1Eqj+W
x6MiEv20DF+sX57vpnPLRre+Br6L/nm+s/WoBY4T6+H9kTw09w9k1NvTVzP+
HevBF5HxfkWumvvLwD8nDwzP6HcbdDxFXnyei/M34ZePl19J0B+5gf55v4f5
5G15gvmZj7Af1rf7E/+/zuL2C/+F+S3+h/VR7ya554vl5fkSeXr9pnwPXxb0
fw/mfbDfP+q4xeE=
          "]]},
        Annotation[#, "Charting`Private`Tag#99"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KAjEQRoM3sbQTtbCbO3gEQbHzKpYqFrYewSqClaCyIAiChcvK4qKI
pf/K5ks+SKYJj8m8mUyKzW6jVVBKlZRS+Ym46e/PhG6buJJXyzwu5KqJs/5Y
Hg7yyPTdMnwn/fJ8qX5aNrrlMfAl+uf5YutRMxwH9kP9ntw393dk9NvSVzH+
DfvBF5FRv2B92dyfB/4puWd4Qr/boOMx8uLzVFy/Ovzy8fILCeYj1zA/73fw
PnlbHuH9zEfYT+A7iP9fsbj9wp8wv8b/sB79Unn4/ysvz5fJ3Zv3zHr4LsH8
12C+G/f1B+gQxd4=
          "]]},
        Annotation[#, "Charting`Private`Tag#100"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkc8KQUEUh0/exNJOWNidd/AIiuy8iiWysPUIVqOsFLqllLIgEpHs/Hd1
5zf3VzNnM32dc75zZiZbbVZqGRHJiUhyIm7mF9swdRtX8myaxMV8HRdtnMnd
ThIn83AM39G8Pd/BvBxb3XRPP3w7Mnxb55ERjg3noX9Nbtv6FRnzlvQVrH9B
hi8io3/C/rytHwf+IblleWBizyeS+vrIa+zxUNN8GX79evmJBvuRS9if9Q3c
Tz+Oe7g/8xHeJ/Bt1P+vrabvC/+O+Tn+h/2Yd9Cn/7/69nwnvXv7ntkP3yXY
/xrsd+N7/QHgWMXZ
          "]]},
        Annotation[#, "Charting`Private`Tag#101"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamG3d/AIgmLnVSxVLGw9gtUWVoKKIAiCRUIkRAwh
XQhRI9m/fphMEx5/581stjmcDkYNpVRLKVV9Uan5lrbM2FZCPh6qis3HcdfW
i7xcVPU0mWP4IlMIX2hyx1Z3eNAPX0CGzzel8Hmch/47eW7P38iYd6WvY/0X
5vCdmaN/z7xtz+9q/i15ZnlT20+pv2+NXJeCt/qf9+HXH5Hvmbv9yD3sz/MT
3E+/Ha9wf+Zn/J+az9PyvXzuB3/A/IT3YT/mhToXvkgXwvfUmfC92A9fzH3h
S2r7peQfjNbTxA==
          "]]},
        Annotation[#, "Charting`Private`Tag#102"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamE3d/AIgmLnVSxVLGw9gtUWVoKKIAiCRUJEFEVS
BULUSPavHybThMfMvJnJVrvDTq9ijKkZY4ovIrbf3IXtu3iRt5sinvbjueni
QZ5OirjbxDN8N5sp39Wmnp1ucyn5Is6DL7S58gWsR//Zvj2PXf2JjHlH+hrO
f2A/fHsy+tfkuqtflfJL8sjxorSfMf95c+RF85Lchl8+Kr9m3u/HfAv7kwe4
T/73znA/83v8H9H3BqLfK5Rc+SPmd3gf7oN5V0mV7yaZ8t0lUb4H++F7cl/4
XqX9Yt7/A3/207o=
          "]]},
        Annotation[#, "Charting`Private`Tag#103"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uCWd/ARBMXNV3FUcXD1ETplcCpUKQiC4NBSKZWW
0qVDQa00f/tDckv4uLsvd0l/vp4tekKIgRCiORGF+tU61FJHrr4tX7wmMvVp
eawjZX6/a+KtypbhS1Rl+GKy1nkv9sMX8X74QlUbvoD16H9ynq2uf5Bx352+
kfbf2A+fT0a/Sx7q+rOVd8gbzSf6uxfs+Ii8NNmRXf8UfjLyrrTmI08wv+z2
W2E/8gH7s97H+1i+QJr/Fcra8EfMX/E/ZNwXy8rwJeT2/2Vp+FLuD19mzZ9b
8xWs/wNuftOt
          "]]},
        Annotation[#, "Charting`Private`Tag#104"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KAjEQRoM3sbQTtbCbO3gEQbHzKpYqFrYewSqFlaAiCIJgscvKoiiy
xTbiz8rmSz5IpgmPmXkzSardYadXUUrVlFLlicj0rzCh+yae+mt5uynjoT+W
mybuzE8nZdx0bhm+q355vpRsdJsL++FLOB++WBeeL2I9+s/cZ2zqT2TMO7K+
YfwHMnx7MvrX7K+b+lWQXzI/Mrzgvu4FHc+RF5+X4nxt+MnIryXYj9zC/uLm
D3A/eVue4f7M7/E+gS8S/79iKTx/wvwO/0PGvFRenu9Ktv8vuee7B75HsP8z
2C/je/0BZW7TpQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#105"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrIQoAUEQLBIioiSI
RZrgTyT7Ng8204SPmfftbLY5nA5GDaVUSylVflEv/StM6bGpp/5a3vtlpfpj
uWsqYX+5KOuhM8vw3XXu+G5ko/OvzMMX83z4Il04vpDzyF/02/LczJ+5H847
cb5j/EcyfAEZ+R3zbTO/JaPvkWeGN9y3+oMVr9EXlz2p8n345ev0d1Lbj9zD
/sxPcD+p7r/C/dkP8H9qvlDc94qkcPwx8we8D+dx3k1yx3cn2/eXzPElzMOX
1vZ/1vZ7kf9gZtOg
          "]]},
        Annotation[#, "Charting`Private`Tag#106"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uB27+AjCIqbr+Ko4uDqI3TK4CSoCIIgOCiVolhK
hy6itdL86Q/JLeHj7r5cLvX+uDeoKaUaSqnyRKT6V5jQQxOJzi3vtmXE+mu5
beJFns/KeOrMMnwP/XZ8EdnotnfPF/I++G66cHxX5tF/0R/LU1N/pg/3nVjf
Mv4jGb4DGf0b9jdN/ZqMfECeGF5xX9UGK14iLy4HUvV34ZfcyW/Em4/cwfzs
H+F9Ur1/gfczf8B+PN9VvP1K4fhD9u/xP6zHfZG8Hd+DbP9fMsf3Yj98sTd/
4s2Xkv9Z7tOd
          "]]},
        Annotation[#, "Charting`Private`Tag#107"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamG3d/AIgmLnVSxVLGw9QqoprAQVQRAEC0UJCRGx
EBLwJ5J9mwe704SPt/PN7KbaHXZ6FaVUTSlVfFFP+eampG/qQd6si7rLx3LT
VEKeToqK5WUZvkhSxxdKZtno1jfPd+U8+C6SO74zc/Sf5G15bM4f6cO8A7lh
/HsyfDv60L9iXjfnl2TkAXlkeCE/x6dUyXPk+utwoMv+NvxeviLb/cgt7M/+
Ae6ny/vPcH/mO7yP5ztr73117viv7N/i/3jzQp05vkinji/WL8eXcB58d+4L
38Pb70n+A0p+05E=
          "]]},
        Annotation[#, "Charting`Private`Tag#108"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLJRISEgI
gRQJaKJkZ/PB7jThMTtvftKdLiezjhCiJ4RovhyZrH4q5FxFCj55TSTyq3mo
IgZvN01EMtfMvlAWhi+QpWal896Wz0c/9r1kbfieyHP9Q340r9X7O3zc7wYe
KP8VzL4LmOtdcF+9P1p5B7xSfLDmE6LlPeepMtihtn7MfjDnXbLmA494fvCC
96N2/x3vj/yF74P++n5k3Zdqw++j/sz/x+oXUGn4QioMX0S54YstX4J52Zda
82XgP0B204g=
          "]]},
        Annotation[#, "Charting`Private`Tag#109"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9gtUWVgEVQRAECyUiiiEE
AkFQo2S/zQe704TH7Lz5SbU77PQqSqmaUqr4IhL9/ZnQfROx/ljerIuIyE0T
T/J0UsRDp5bhu+vM8d30y7LRra+eL2R/+C46d3xn5lF/0m/LY/P+SB/6HcgN
49+T4duRUR+Q6+b9yssvySPDC28+pcr55siLy0sp69vwk5EPxJuP3ML8Uu47
wH7kGfYn73Af9rf3E+++kjv+kPVb/B/2R7+bvBzfXTLH95DU8T1ZD1/kzR97
8yXkPzfu04E=
          "]]},
        Annotation[#, "Charting`Private`Tag#110"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb0KwjAURoNv4ugm6uCWd/ARBMXNV3FUcXD1ETrdwalQRRAEwaFSKZaW
UihU8adKc9MPkruEw809+ZI0h9PBqCGEaAkhqpUro89PFY1VpeCdV1VCb81d
VTH6y0VVEeWa2XenwvCF9NSsdN7N8gX0NXxXKg2fjz7PX+ilea72n638J3BH
+Y84j30HMM+74Lbav8U89x3wTPHGyidEnW/NfWmyI+v5PvvB3HfBOp+s8/Q4
P3jC9wOv+P7gA7+P5fOl9b6yNPwB5vf8P5jn80L5MP9XFoYvkrnhizHPvsTK
n1r5MvAfKA7TdQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#111"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamG3d/AIgmLnVSxVLGw9QqoprAJRBEEQLCKRkJAQ
QiAE/Cc7mw92pwmPmXk7M2mP56NJSwjREULUX46c3j8VNFWRgQ9eHSm9NPdV
JMivV3XEVGhmX0Sl4Qup0qx03sPyBfQxfHf6Gj4fee6/0VPzUtVfrfkv4J7y
n/Ee+05g7nfBXVW/Rz/nHfBC8Q7zNBdseMt5+TbYkY1/yH4r74L1fKgf8Pzg
Ge8nm/03vD/yJ76P5fOldV/5NfwB+o/8f9DP74WyMnyRLA1fLAvDl6Cffak1
f2bNl4P/HDbTbA==
          "]]},
        Annotation[#, "Charting`Private`Tag#112"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamG3d/AIgmLnVSxVLGw9QqotrAJRBEEQLCKRYEgI
IRAFTVAys/mwO014zMzbv5v2eD6atIQQHSFE/eXKVPmjUlOqVH01H7y6EnCf
Ksb8elVXpHLN7HuqwvCF6q2ZdN7D8gWW764qw+ejz/s39dG8pPmrlf8C7pH/
jPPYdwLzvgvu0vwe+9x30F8Q76x8QjS85b4sDXZkk3fIfqvvgnU+2Zw34Pzg
Gd8Pvg3fH/0Tv4/l86X1vrIy/AH2j/x/MM/nhfJl/l9ZGL5I5oYvxj77EuRl
X2rly8B/D3bTYg==
          "]]},
        Annotation[#, "Charting`Private`Tag#113"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uCWd/ARBMXNV3FUcXD1ETplcCpUEQRBcKhUiqWl
lEIVtEVpLv0hd0v4uLvvLkl7PB9NWkKIjhCiPikyVf50qKmOVH0NH7w6EnBf
R4z69aqOSOWGyfdUheUL1duw1nkP5guY764qy+cjT/039TG81PVX+GjeBfU9
7T8jT74TmPpdcFfX71neAS8079h+QjS8pbwsLXZks++Q/Czvgs1+spk3oP3R
P6P7gTd0f9Sf6H2Yz5fsfWVl+QP4jvQ/qKd5oXzZ/ysLyxfJ3PLF6CdfwvZP
2X4Z+A8KxtNe
          "]]},
        Annotation[#, "Charting`Private`Tag#114"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAUhBdvYmknamG3d/AIgmLnVSxVLGw9QqotrAIqAUEQLCKRYEgI
IQQFf1CykwzsTrMM89733u42h9PBqCGEaAkhyhPK1OenpcZaqXpXfr8rldB3
tWLWLxelIpVXHry7KgxeqJ6V17jdTb0MXmDxrvTg+ZyP/gv757r+zBzzTuzv
aP6ROXgePfpd+rau31q5Qz/TfqO+Bk+Iet4auTS9I+t9++BbuSvN+3qyntfD
/uyf4H70K9yf9R7ex+L5zKv3ZQ5+QN4B/8N6zAvlw/xfWRi8SOYGL2Y/eIm1
f2rtl9H/Af7301Q=
          "]]},
        Annotation[#, "Charting`Private`Tag#115"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrIQoAUEQLBRFFEUU
guIfSvYlD2ZfEx4z75uZbL7erjVyxpiCMSb5Qlf7+TnZptPFvlM/DROd6ctO
J/p+L9HR3lIP3sHGire3j9Q7XLizL8Xbcj54G3rw1pyH/Ir5rutfso55C+ZL
jj9nHbyIHvkJfdH1j716QN9xfmS/imdMNm+IuryVDyTbtwq+6P6J6Hsj5ivY
n/kW7pNn6ge4n/UI/8fjrUW/14Z18LfMz/A+7Me8vdz1+0qseEe5Kd7J4529
/S/eflf6P/b/000=
          "]]},
        Annotation[#, "Charting`Private`Tag#116"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrIQoAUEQLBRFFEUU
ouAfSvYlD2anCY+Z972ZbL7erjVyxpiCMSb5oq7283Nlm64u9p3qaZjUmbrs
6kTd7yV1tLdUg3ewseLt7T3VDhfu7EvxtswHb0MN3pp58K/o77r5JfvIW1CX
HH9ODV5EDf+Euujmx14/YF7H6ZH9Kp4x2b5D9OWtdCCZvwq+6PmJ6Hsj+ivY
n/4W7pNnqge4n/0I/8fjrUW/14Z98Lf0z/A+nEfeXh76fSVWvKPcFO/k8c7e
/hdvvyvz/u+H00g=
          "]]},
        Annotation[#, "Charting`Private`Tag#117"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRgdvYmknamG3d/AIgmLnVSxVLGw9gtUWVoEogiAIFgmRkKBI
Alr4h5KZ+MHsNOHxzbydzVa7w06vQkQ1Iiq+Upl9fblsn+sKXvtFXcBNrjN4
OikqtXnJ4kvsTfliey+Zdf7JPpUvsm/lC8HiC3CezB8xP+b+A1jO26O/wf4d
cvFtkcu8h7zO/SsnXyIfMS/sR/mI/vvOJTcvxUvzn2+L38k9cLkfuCX7Y34g
9zOPkmdyf+Rb+T+OLzD6vULzVv4Ivo28D/rlvNjclS8xN+VLTa58Z+wjvouz
/9XZLwP/AOQn0z4=
          "]]},
        Annotation[#, "Charting`Private`Tag#118"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRQdvYmknamG3d/AIgmLnVSxVLGw9QqotrAJRAoIgWEQiwZAQ
AtFCE1Gys/mwO014/Jm3s5v2eD6atIioQ0T1lyuX5U+VnKrK5EfzwasrBfdV
Jehfr+qKZa6ZfQ9ZGL5IPjUrnXe3fKHlu8nK8AXo5/kreKn6L2A+7wxfT/lP
yNnnI+d5F3lX9e+t3EG+ULyTX8NH1Oy75VyUBjvirXnIfit3wXo/8ID3x/yM
7wfe8P1Fs5/P72P5AuT6fUVl+EP4jvx/0M/nReJl/l9RGL5Y5IYvwTz7Umv/
zNovB/8B0LfTMA==
          "]]},
        Annotation[#, "Charting`Private`Tag#119"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamG3d/AIgmLnVSxVLGw9QqoprAJRAoIgWEQiwZAQ
AlFQE1Cys/mwO014/Jm3s5v2eD6atIQQHSFE/eXKqfypoqmqjL6aD15dKbiv
KkH/elVXTJlm9j2oMHwRPTUrnXe3fKHlu1Fl+AL08/yVPpqXqv+CnM87w9dT
/hNy9vlgnnfBXdW/xzznDvKF4p21nxANbzmXpcGObPYdst/KXbDeTzbnDXh/
zM/4fvKtecP3R7/P72P5AuT6fWVl+EP4j/x/0M/nRfJl/l9ZGL5YZoYvwTz7
Umv/zNovB/8BxP/TJw==
          "]]},
        Annotation[#, "Charting`Private`Tag#120"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRAoIgWCiRYMgP
CSj4E1Cys3mwO83yeG++nZ1tDqeDUUMI0RJCVCdXLr8/VXKsKpMfrXdeVQl0
V1WM/HJRVSRTrZl3l4XBC+VDa4XzbhYvsHhXWRq8C/Lcf5Zvrecqf4LP9x3B
6yj+AT7zfGjud6HbKr9FP/sO/JnSG2s+Ier8mn0ytUP1vH3mW75L1nzQPZ4f
/RN+H720XvH7kfd5P+Dr/cHX+6XS4Afg7/l/kOf7Qnqa/0uFwYsoNXixxUus
+TNrvhz6D7rH0x4=
          "]]},
        Annotation[#, "Charting`Private`Tag#121"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLJRIMOSH
BRE0BpTsbD7YnSY8ZvbNt5vmcDoYNYQQLSFE9eVS8vvTJce6clkY3gVVpeCu
rgTzy0VVscwMs+8hleWL5NOw1gV3xxeC2XeTpeW7os/nL/JjeK7nz+jzvhPy
dbT/iD77DmA+74Pben7r9D3wTPPGySdEvW/NfbLZozpvn/1UWH2fnHzgHufH
+Qnfj96GV3x/zB/4fbDfvB8570ul5Q/h3/P/wTzvi+hl/19Sli+mzPIlji91
8ufOfRXy/gGxX9MX
          "]]},
        Annotation[#, "Charting`Private`Tag#122"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhQdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRAoIgWCiRYMgP
CyJoFJTsbAZ2XrM83sy3M7vN4XQwagBACwCqk6RV+TNSY6NCva3fBZUyzrtG
KfvlolKicuuJd1fa4cXqYb3BBTfBiwTvqj4O78I59Z95vrmpP4n5j9zfMfwD
58QL2VO/z75t6rci99jPjN+or8MDqO9bU46u97Cet098LJ3cRzEf+x7Nz/0T
2g9f1q9of64P6X1QvB+K9+Wc+BHz9/Q/XE/3xfh0/xe1w0swd3ip4GVi/kLs
q9n/Aadv0xE=
          "]]},
        Annotation[#, "Charting`Private`Tag#123"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb8KwkAMhw/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4CRUKQiC4KBUimIp
BRH8B0ov1x/kshwfyX1J7qrdYadXMcbUjDHFKZHz+2eD+zYyfjleh0Wk4KaN
G+qnkyKunDoW34Vz5Uv47tjqwrPniz3fiT/Kd0Re7h/46Xhs6/fe/Dtww/q3
6Ce+CCz3V6iv2/olWPIBeGR5wV/lM6acdy550hxQ2a8tfnqr/Ars5kN9S+YH
D2Q/Kvefyf64H8n7kPd+5L0v8uKP4d/I/6Be+iX00P9LufJdKVW+m+dLMa/4
MtL/kWP/P5hX0wY=
          "]]},
        Annotation[#, "Charting`Private`Tag#124"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb1qAlEQhS95E8t0QVOkm3fIIwQUO1/FUkOKtHkEqymsFlZZEATBIrIi
kV3kElLoRlD2nrsHZqe5HM7Md+en8zZ67T845x6dc/WL8FrdQuggxEkvUS/S
OkrqXoiC+e/TOo5aRg3ej3rDO+hv1AGX7lu8vMXb6b/hfdNH/VbPUU9C/oY8
/LdmfjfwV/TBy6hRn1A/hfw56+HPqMdBf+nV8Jxr+v2EL1bPpOG/gC+V8RPq
2B/zn9E/9RDzSTP/B+ZnfYb9SGt/0tovffBz8pa4D/Px30H+7H3FG95RCsMr
2C94JfngncTew3P+O5Gn0wA=
          "]]},
        Annotation[#, "Charting`Private`Tag#125"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbFqAkEQhpe8iaVdiCns5h18BCFi56tYRrFI6yNcNUUqQUUQBMEiYjg8
7jiOpIlnIOH23/thdprlY2a+ndntDCeDlwfnXNc515yISus/HzryUeot8Gbd
REHu+chZP581kWkeGL6rVsaX6ldgr1t/Rr4LGb6z3o3vg/eh/6Q/gV99/ZH9
uO/A+ifv3zMP346M/hX50de/sx/5hDz1vNRf43OunfcNeakNJ9L6+/BH+ZVE
85GfMb+0+46xH3mB/Vm/w/vQH95P7H+d5W78F/q2+B/W475Uvu3/SmV8meTG
l3Me+Ipo/jLat+K8/4hH0vg=
          "]]},
        Annotation[#, "Charting`Private`Tag#126"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9gtUUVoEoAUEQLJSIKBEJ
WvgTQcnO5sHsNMvjzX7zZrfc7rc6JWNMxRiTn1Ipf362uGvrxi+nl2FeV+i6
rQT941FeF06cFt6ZU8U78d1piwuP/Fa8GFp4B84Ubw9f7u+QZ2j7t/Bl3ga6
Zvlr9Asvgi/3A+iq7V94/hz7Dqye8VfxjCnyTsWnj9JzKnhN4Xt+AN/lg25I
firy92Q/ejo9kf3RH8n7gO/ej7z3pUzxY/BX8j+4L/NO9ND/S6niXShRvATz
hHf18t+8fVPk/QN7J9Lw
          "]]},
        Annotation[#, "Charting`Private`Tag#127"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9gtUWVkKUgCAIFooSzA9R
tPCvULJv82AzTfiYN9/OZsvtfqtTUkpVlFLZF3XTn58p3TWV6pfllZdVQq6b
ivXb8niUVagjy/Bd9NXxBfpu2ei8M+fhO9EP31F/Hd+BeczvmR+a/I6M87bM
14x/wz58PvuYX5KrJr8o9OfkgeFZYT+lcp6iLx+H55LPN+Ev9Jfs2/3IDewv
+f493E+elie4P/M+/g/99v+J+15H+Tr+E/1rvA/zOC+Qh/u+cnV8oUSOL+Y8
fAn3hS8t3PdG/gNsd9Lk
          "]]},
        Annotation[#, "Charting`Private`Tag#128"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTsKwkAQhhdvYmknamE3d/AIgmLnVSxVLGw9gtUWVoEogiAIFoaIJCYk
ksJHLJTsbH6YTLN8zL/f7KPeH/cGNaVUQylVrFwP/fmZ0kNTiX5b3rpFxeC2
qQj5+ayoUN8tsy/QqfDddGbZ6NxrxeeD2efpXPgumMf7z8hPTf4E5nlH5FvG
f0CffXv0eb8Dbpr8ptJfgyeGV/orfEqVvOQ+5YLXVM7vsp8+ou+A7fnAHT4/
9o/4fvS0vOD7I7/n96HK+5H8Lw999vvw7/h/kOd5N8qEL6BU+EIKhS+q+GJ6
CV9C8j8euP8fYS/S2Q==
          "]]},
        Annotation[#, "Charting`Private`Tag#129"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3S6walQRRAEwUFRiqWl
rQ5qdVB6OX/IZTk+knyXu1S7w06vopSqKaXKkyPXxdeE7ptI9cvyKigjATdN
xKifTsqIdGSZfVedCV+ob5aNLrg4vjOYfSf9Fr4j8tx/AI9N/R7M9+0wX8P4
t8izb+P0++C6qV86eQ++keGF/gifUv9555wnyR79fW32UyHyPtjOh/oWz09P
ywN+Hz0sz/j96N/w/zi+Izn/i/nYf0Z+zftBP98X0l3ulzLhiygSvtjxJc78
Kcl95OAfUa/SzQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#130"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkjEKwkAQRQdvYmknamE3d/AIgmLnVSxVLGw9gtUUVoEoAUEQLCKKGJSg
Fmq0ULKz+bA7TXj82bezuym3+61OiYgqRJR/tW6S/UxJ11Qqb8vLMK8ruG7q
Ah6P8koksay+s6SO7yR3y0YXHj3fwfPt5eP4YuS6ficvy0PTv0Wu+21wnprx
r5GrLwLr+gBcNf0LL5/DNzA8k6/jIyrmnWrOLs+58DXVz5mTB2A7H/obOj8X
5+3p+fhpeaLnR3+k9+P5YvbuF/Op/4B8pe8D1v1O/HDfl1PHl/DZ8V0839Wb
PwXb/w/9f0lP0sU=
          "]]},
        Annotation[#, "Charting`Private`Tag#131"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLCKRkJAQ
goUaGyU7mw+z0yyfP/vm72x7PB9NWkqpjlKqPrlKXf1M6ampQr+tPgR15fpj
dd9UBr1e1ZXqxGrmJboQvFiXVhtc8HB4kcO766/ghfD5/g35lqb/Cp/nXaB7
hn9GP/NO8Pm+D901/XvH97CfhdE7J59Sjd6yT1J71PCGzKdK+D60zYf+Aeen
Jv+M30cvqzf8fvSfeD8OLyRnv8jH/Aj+kf8HmufF9JT/S4XgpZQIXoa8zMud
/AXJ/ygx7w89d9K+
          "]]},
        Annotation[#, "Charting`Private`Tag#132"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KAkEMRgdvYmknamGXO3gEQbHzKpYqFrYewSqFlaAiCIJgoSiyoiyL
hX+NsvPNfpBNMzwyeUlmis1uo1VwzpWcc+mJSPTz86FtH7G+Ai8Xadz1Hbjq
40YeDtK4ahQYvkhj47toEtjrFuec78R+8B05D3wH5lG/12fgvr+/ow/9tuSK
929YD9+aedTPyWV/f5bLTzlPz/NEv8bnXMZj5MXyVLL+dfjlY/Jzedv5yDXM
z/oO9pNs/xH25/013kdy7ye592Ue/hPrV/gfMvpd5GH/V2Lju0pkfDf2g+/O
eeGLxf5Hwv3/Mh/StQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#133"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTuKAkEQhhtvYmgm6wZmdQePIChmXsVQxcDUI0xUgZGgIiwsCAYrig8c
hkHwmbhM/z0/1FTSfFTVV9Xd5Wa30So55yrOuexEpPr6+NC2j0QfgRfzLGJ9
Bq75uJCHgyzOegoM30kT4ztoGtjr5vuCb8d58G25D3x/zKN/o/fAfV+/pg/z
fslf3v/DfvhWzKN/xnzV10/JyEes73me6Nv4nMv3HSMvliPJfXX45WnyM3LY
j/yN/SW/bwf3I49wf9av8D5SeD8pvC/z8O/Yv8T/kDHvIFf7v5IY31mOxnfh
PPhiuRlfIvY/UvI/KL/Sqw==
          "]]},
        Annotation[#, "Charting`Private`Tag#134"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbFqAkEQhhffxNJO1MJu3iGPICjp8iqWUSxs8whWU6QSNAhCIJAi4cKd
xx3nWWhMGuX23/th7m+Wn3/229mZ9ujpYdxyznWcc9UJlfp389KJV6G/wW83
lXL6vldGP59VSjUJHryDFoYX6zF4j9v86NXwogbvm/2A98Uc9z/1Evyzr/9g
jvfeye95/p45eDvmuL8mr+vrX1mPfMX6qfcv+m94ztX9LpGL9SupeUPw5Wry
NX3oj36A/qXu7xH/o1/g/6zfYT7SmJ805ssc/Ij5G/ZDHt6L5WT3K4XhpZIY
Xsb+wMvlbHiF2H2U9HcbF9Ki
          "]]},
        Annotation[#, "Charting`Private`Tag#135"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FSoUhAEwUGpVEWp
OqjVRenl+kOa5fhI8uUuV273W52SMaZijMlOiTt/fja4ayPht+NFkMUVXLdx
AY9HWZz56Fh8J06UL+abY6sLDgVfVPDtOVW+Hb9U/xY8tPUb9Mu8Nbhm/Suw
+EKw9PvwVW39vJD3cJ+B5Rl/lc+YfH9TyZNmj3JfU/yUqrxP+r0h6htyf8rv
15P3gSfyftSHsh/Md/tDvdsv5ok/Qv9S/gd5mRfTQ/8vJcp3plj5Lpgnvis9
lS8h/R938B8Oh9KY
          "]]},
        Annotation[#, "Charting`Private`Tag#136"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbFKxFAQRR/+iaWdqIXd/IOfICh2/sqWq1jY+gmpprAKRAkIgrDFStZg
2E02xeJubHbJ3JcLk2nC4c6ceS/v+Pr+6uYohHASQui/qFa7vZXeWjW6jfyW
9bXSv8jnVkvmjw99VVpGhu9Xa+crdR3ZdNmC8/AVI9+37pxvzv2Yn5Gn1v/F
eez7JJ+Z/4MMX07GfErfqfW/jvKE55kYv+i/84Uw5M/IpXOcyOC7hJ+MPBV/
35z5Bc4vw/nucD/yE+7P/hz/Z+Sbsz/+X+bwF5x/x/uQsa+U1r+v1M5XyY/z
LbkPvpVsnK8R/x4t+QAC39KN
          "]]},
        Annotation[#, "Charting`Private`Tag#137"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTsKAjEQhgdvYmknamE3d/AIgmLnVSxVLGw9glUKK0FlQRAEi5VVUQzL
Fj4rZTPZHybThI/J/00e5Xa/1SkRUYWI8lUqM++fK9N1lYLXq7yseXmuu7qj
Px7ldTNnz+K7Gqt8F5N6drrVCXnxJYHvaD7KF2O+5A/godu/D86/A9ecfwsW
XxTkl+Cq278I+nPkB45n5qt8RMV5p9Lnr+I5F/mm+MHSX7K+b8TF/IacH9yT
+/HT80TuD18k7xP4YuT9+6Iv/gT5jfwPWOZdONP/y1b5bnxWvjvmic/yQ/lS
1v+Rgf/vINKB
          "]]},
        Annotation[#, "Charting`Private`Tag#138"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb0KwkAMgINv4ugm6uCWd/ARBMXNV3FUcXD1ETrd4FRQKQiC4NBSWyw9
Sgf/Oim9XAO5LOUjuS9J0x7PR5MWAHQAoP5SlOrzM6GmJgrm46EOrd6W+yZy
5vWqjkwllsn3UFr4UlVYNrrD3fHF3I98kfoKX8j19P7GvDT1V2f+C3PP+M9c
T77Aee8zd0393sl77FsY3qlK+ACaebeUx0qwh837IfmZKe+j3DfApv+A5mee
0X74sryh/dkX0P9xfCHKe0WcJ3/M+RPdh33UL8VS3he18GWYCF/u+DQ+ha9A
eY+S+/0B6GjSfA==
          "]]},
        Annotation[#, "Charting`Private`Tag#139"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLAyJwZAQ
UvhbKdnZfDA7zfKY3TczO83hdDBqKKVaSqnq5Cj1+2dCj00U+mV5F1SRg7sm
MvByUUWqb5bZd9eZ8CW6sGx0Qez4ItRnX6g/wnfFfX5/Ac/N/TOY653g6xj/
EXn2HZz3Prht7m+dvAffzPBGf4VPqbrfNedJskf1+z77wZz3wbY/quv3uH/w
hOejp+UVz4/8gf+HnP8jua8QefZH8O15P+iH6yVUyv1SJnwpxcKXOb6cHsJX
kNxHifn/3YjScg==
          "]]},
        Annotation[#, "Charting`Private`Tag#140"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9gtUWVoJKQBAEi4hB1ERJ
4V+nZL/kg9lplsfMvpnZLbf7rU7JGFMxxmQnIrWfnwvbdfGwr5zXqywS+865
7iImj0dZXG2UM3wXe1O+s73n7HSryPOdPN+R88AXMo/7B843dPV75tFvR645
/5YMX0DG/SW56uoXXn7OeQaOZ/arfMYUPEVeNM+luN+En4z8UvS+gRT9G5hf
in172I88wf6sD/A+oucLxXtf9oP/RN8G/8M8+p0l1f8rN+W7SqR8sedL5Kl8
D9H/kZL/yaDSZQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#141"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FRQKQiC4FBpKR4t
tYNaN6WXu0Auy/HzJ1+SS3s8H01aSqmOUqp5KSr8/Ezg1ESJb6uPhyYK1n0T
OeevV01oTK0m3gO14GVYWG1wh5TriZd4vDvWghezT/U3fFm9NPlXb/4L657h
n3l+4kXsU33Iumvy954f8DwLo3f4FTylnN6SD7XQAesh8T0/BLlvBK7/gOYH
N/+M9gO3/4b25/yI/sfjxeD9L/vET5h/ovtwPvXL4CnvC1rwNKSCl3u8gucl
XgnyHhX3+wO4uNJY
          "]]},
        Annotation[#, "Charting`Private`Tag#142"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbFKA0EQhhffxNJOooXdvIOPEEhI56tYarCw9RGumsIqkIRAQAikUO44
stwRA+rFLuH23/1hdprjY2a+m5m9HD7cjy6cc1fOuf6LOGh3CqHjEHv9i7yY
99GSb0I0rJ8+9+G1igzfTr3x1dpGDrp5xX74ysz3pUfj+2Qe/Vv9jfwU6jfZ
/B/kQfCvOT98KzL6Z6y/DvXvZOQLzvMY+E3/jc+5xK/IS2e4kNR/Bz8Z+Rnr
43yS5rvF/OQJ9pO0/wv2Z36F+0h2P8nuyzz8JfuXeB/W43+1fNv3FW98Xirj
azJfKz/Gtxf7Hgfufway+NJS
          "]]},
        Annotation[#, "Charting`Private`Tag#143"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KAjEQRoM3sbQTtbCbO3gEQbHzKpYqFrYewWoKK0FFEATBQtlFXFxU
8LdTNl/2g2Sa8JjJy8yk2Ow2WgVjTMkYk52Iu75/NrRt46ovx8tFFim5auPC
+uEgi0Rjx/CdNfF8J00dW90iDnxR4Dvqx/MdmMf9vT4d9239jj68t2V9xfo3
zMO3JuP+nFy29TPeR35K7lme6NfzGZPzGHl5ezwl1+EP8nOy60/yfmroX/J5
O5hPHo5HmJ/1a+xHgv1JsF/m4Y/oX+F/WI/3TnLz/1cSz5dI7Pku7Ae+lP3C
dxX/P+6c/w+noNJJ
          "]]},
        Annotation[#, "Charting`Private`Tag#144"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbFKxEAQhhffxPI6OS3s5h18BOEOO1/FUg8LWx8h1RRXHeQkIAiChZIj
JCTEgHpep2T+zQ+z04SPmfny7+7x5fXF4iiEMAshjF/UoD9/Vrq06vU78jYf
qyOfWrWcX92N1eguMny11s5XaRfZdPmO+/CVune+D/11vnf2sf/GPLc2/5rk
f+H83PzP7MNXkLG/IZ/Y/Jr76GfkG+NHPThfCFPeB/Rl7zgjn8Of9DfkmE+m
PGfIL9N5r3A++Yp8j/NzvsD9SHJ/ktwv+/CX9D/hfTiP/1Xy6d9XaudrpHS+
NvF1zAtfL/49BvI/mYDSPw==
          "]]},
        Annotation[#, "Charting`Private`Tag#145"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9gtUUVoKKIAiChRLxh0gQ
/CuV7Ns8mEwTPmb22zfZYrPbaBWccyXnXPpFPfT986VtX4k+Ay8Xad31Fbjq
K+b8cJDWTaPA8F31YnxnjQN73eLE8/BFOd9RP8Z3IOP8nvn6fn6Xy7/lfMX7
N8wP35rzOD8nl/38LNefknueJ/o1Puey+8boi+UpuQ6/vE1/Tg75yDXklyx/
B/tJtv8I+7O/xv8Rm+/A+8P/JcMf8fwK78M+7jtLYt9XLsZ3k8j4YuaD706G
LxH7Hg/u/wd+0NIr
          "]]},
        Annotation[#, "Charting`Private`Tag#146"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FRQEQRBcFAqam0p
glZHpZfrD7ksx0eSL7m7anfY6VWMMTVjTHFKPDn/2eC+jYxfjterIlJw00bC
b8fTSRExR47Fd+eb8l354djqVhf0iy/yfGf+KN8J+0n/EfuMbf3B23+P/ob1
7+AX3xYs/SG4buuXXj4Ajywv+Kt8xpTz5pInzQG4LX7KVT4Eu/2onNeS/am8
70DuB57J/VG/lfch7/3gd++LvPgj+DbyP6iXeVfK9P/STfliOilf4vlSb/+M
9H88wX9mwNIX
          "]]},
        Annotation[#, "Charting`Private`Tag#147"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkj0KwkAQRhdvYmknamG3d/AIgmLnVSxVLGw9QqoprAIqgiAIghGDGBKC
+Fsq2W/3g8004TEzb2Z3U+0OO72KUqqmlCq+iLu8fiakbyKXp+X1qoiM3DSR
sn46KSKRyDJ8N4k931USy0a3itkP36XkO8vH80Xy9vqP8rA8NvUH5jFvz/6G
8e/oh29LRn9Irpv6ZSkfkEeGF/L1fEq5eXPktc+Bdvu14ScjH5LtftrNa2F/
7e5/gPNpd/4Zzs/6Le6n5IvI9n65H/wX+jd4H9Zj3lXn/vvq2PMl+uT50pIv
477w5czb/4/8B05o0gQ=
          "]]},
        Annotation[#, "Charting`Private`Tag#148"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdksEKQVEQhk/exNJOWNidd/AIiuy8iiWysPUIVrOwuoWUUopcHYnoJlyW
dGfO/WvObG5//5xv/jnnFpvdRqtgjCkZY7Kv1IPePy5qcyX09Hoxz+pOL6+r
XDf0DwdZXengtfAu5BTvTBevGTc/BTwX8I70UbyYUnV+h3x97t8G+Tc4X2H+
Gr7wVtByPkKeMvfPAn8Kv8d6Ql/FMyafNxbfaj21Oa8ufGjxI5vqfPBrkt/m
8zuyn833H8n+6F/J/QS8GNrfL/IJ34G/lPcBT+adbaLf1zrFu9q94t0C3h15
hZfA9/8f9B862NH2
          "]]},
        Annotation[#, "Charting`Private`Tag#149"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb8KwkAMxg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FSoIgiC1KFyUlpa
Sv1TV6WXayCX5fhI7pcvSXs8H01aSqmOUqp+KUr8/Ezg1ESBL6sPQR05vq3u
m8i4fr2qI8XQauIlqAUvxsRqgwseDk87vDt+BS/CSvy/4dPqpam/Mo/6Xbi+
Z/hnzhPvxJr++8zrmvq9k/d4Hwujd44/pRq9pTxI7UEz35D4rCnvQyX9QdN/
QP6h6T+j+VhvaH6uP9F+HF7E2u6X/RFf8/8j3Yf9Ub8YCnlf0IKXQih4Gfsj
Xu74L0Deo2T9Bx5o0eI=
          "]]},
        Annotation[#, "Charting`Private`Tag#150"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkj0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqoprAQVQRAkFoaIP6hB
40+rZGfzYHaa8Hiz37zZTbHZbbQKxpiSMSb7Sj349bPFbVsJp04v5lndoKu2
rugfDrK6cOi08M4cK96RT05b3Pzg8WJ+K17EH8XbY56c3/HT6b7t33r5N+BV
LH8NX3grzJfzM/DKtn/q+QF0z+qJl8+Yr9Nj8emjdEB5nrrwKVX+DL7LB78m
+aE7sh/0SPanfL+V3A9590f6vSL4wo8p338p74M8Mu9Id/2+FCvehULFuyKf
8G5e/gTa/X/Qf/4B0ck=
          "]]},
        Annotation[#, "Charting`Private`Tag#151"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkTEKwlAMQD/exNFN1MEtd/AIguLmVRxVHFw9glMGJ0FFEASLg/KlWluk
auuq9CcG8rOUR5LX5Kfc7rc6JWNMxRhTfClSfH9dYNfFA1/M61URiXDdRSz1
41EREQbM5LuhVb4Qr8xOt7p4Puv5zpgr30nqqf+IT+ahqz948+8xY645/076
ybcVpv4lpsxVV7/w8nPhgeOZN58xH+Yp5SFTPBdukh9eKr+UPM8n+QbNL9yj
/eC//4T2h//+W3ofz3eSfn5fyJXfim9D9xEf/S+Eu74vWOWLIFC+2PMl3vwP
0PdIhX/u+dG6
          "]]},
        Annotation[#, "Charting`Private`Tag#152"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkb0KwkAMgA/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FSoIgiCxaFSqUpL
rf2ZlV6ugVyW4yO5L7lLezwfTVpKqY5Sqj4pMsx/OnCqI8Wv4YNXR8L5vo4Y
C8PrVR1v9A2T74WB8EX4NKx13sPyhczku2MlfAHn6f6N51vq+isz9btgabin
/WfMhO9k3Xc539X1e+5HeYd5oXlnzadUw1vKQyHYYR6SH3KRd6GU80Ez34Dm
Z57R+5g39H72n+h/LF8A1v9CJfwh+460H/ZRvwhecr8QCN8bfOGLLV8CH+FL
Qe4j4/o/0MHRnw==
          "]]},
        Annotation[#, "Charting`Private`Tag#153"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdksFKw0AQhhffpEdvYnvobd7BRxAs3nyVHm3x4NVH6GkOngKpBAQhICQS
Gw0pNTHtWcn+mx8mcwkfM/PtzG4m13dXN2fOuXPnXP9FNNr++dCFjwN5G/ex
J0991PobeL3qo9I0MHzfmhlfqbvAXhd/jnzFyPehnfHlzKP/nf33vj7Vxpz3
xvpL739lHr6EjP6IfOHrn9mP/Ia89PykR+Nz7hT4EXnpDG9k6J/DL63JR2L3
TWSYZ4b5ybfYj/0P2J/9Ce5H7Hy5jO6X9fAX8hP4Be/DPM4r5cu+r2TGV0lq
fDXnhW9PP3wHcvj/WP8PqbHRgQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#154"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkj2KAkEQhRtvYriZqIFZ3cEjCIqZVzHUZYNNPYJRBUaCysCAsLCIMoO7
osz4lyvTr+dBTSXDo15/9ap76r1Rt19zzn0454ov6qrXly8d+Mr0FvR6VdRF
86Bbvs56D/pzWtRJ46DB+9ed4R01DdrjVin54CXkg3cgH7w9/Tj/y7wT7/+p
5N/S3/T8mH3wosr5JXXD+xc8j/6ceuz1TJ+G51ypv9GXh9FzKffpgC+56S/F
7htJmaeN/NRD7Cdlni/sz3kR7qfC29Mf7pd98BPm2eB96Me8o/zZ95Wd4Z0k
Nrwz84J3kczwMs4L/x/9b3WR0Vs=
          "]]},
        Annotation[#, "Charting`Private`Tag#155"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkr1KxFAQhS++ieV2y2phN++wjyAodr6KpYqFrY+w1RRbBbIhIAiigUiW
YMiaxPgAK7lncuDeacLhzHzzc3N6ebu+OnHOLZxz0xcx6HD0odc+Ov01vUun
OGhv+sxHq6Ppx4cpGs1Mg/etRcCrtTLtcek+4lX6E/C+2B+8khr1n5z33ue/
R/O/MX/l+a/0wcvZH/UJ/aXP30b8DfWd1y/cf77gn+ln+DIGeiNz/QX40gd+
IiEvp3+O+Vl/g/2on7C/zPvmuE/EK+nbfanBr6QzneF96KNfLR/h+0oR8BrJ
Al7L+cA7kA9ex/3s/2P+P0R50S4=
          "]]},
        Annotation[#, "Charting`Private`Tag#156"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkjEKwlAMhh/exNFN1MEtd/AIguLmVRxVHFw9QqcMToUqhYIgWGipFEtr
bb2A0pf3AnlZyk+S709e2p+vZ4ueUmqglOq+FA1+fjpwqaPGxuhL0EXF+bGO
Eluj97suCgyMJt4LY8HLMTFa44In1oKX4VvwUvYjXsJ+1P/g/q2uvzvz37h+
pPmRwwuxEv0+54e6/uzkPfbbaH3iee0Lfo0+Uh6k9sDyp8RnTXkfWjkfWP8J
zQ/Wb0X7gb3PgfZnHdL7OLwE5L1S9id+Bna/K92H68kvh0jeF2LBKyAQvJL5
xKuc+Wv2M/8fz/8H/xrQ9g==
          "]]},
        Annotation[#, "Charting`Private`Tag#157"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxdkjEKwkAQRRdvYmknamE3d/AIgmLnVSxVLGw9gtUUVkIUQRCEgJFoSMga
gxdQsrP5ME6zfP7Mm5ndbQ6ng1HDGNMyxlSnRMnvrwseuyigD0EVllOvuy5y
+MtFFRkHXgsv5VDxEr557XDBg63ixdDCu3OheBGXqj7kl9dzl39FvvS7IL/j
+GfMK7wT+kn9HvVtl7/DvuJvOfN65vSGc8Uzpq5fi08fpbdU+33hk1X+nko9
H/yezA89kf2o3n8l+6P+JPdDet8Ivr9fzCP8mOp9jvI+8KVfQkf9vhQqXkaB
4uX0VDz7N3+B+f3/Q78fqZLQqw==
          "]]},
        Annotation[#, "Charting`Private`Tag#158"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kksohFEUx2+mxEoWHgsbG6FIKFPkKEWyQikL0sgMCY1EeSxGkkGTx8Jz
xI7IgoUsdDCjjAaDPJPXaGZkmmajvjEfae499yy+r9u593fO+f9Pqq6zujmK
MZbBGIv8RQQxo2jnajmoop5HAOMqwjWtPhXPnJHwo8vb/v13oWIejy+s3Dae
sDUVF+Yj8YnW0g5Nr1FFwfPhVULb4WmW5HnQbt3o2n8OI8c5P7Bn9yCzYSRM
PDf2jd3/qmlh4r2hb9FkTbH9EO8VowoNdbr6H3r/hKbsbsuwEsI5fv8B4xPd
jQWzIap3i8fj5tqkohDmcv41Gi7fNVOfCvFceFS8MGFfVei9A0tivX1NegVz
+H0bbs1U9YxqZX4PLwdezJZkBSf5eR0fB6c9mmjJYyyGfxVcEXm4o7w478EN
vdcKPmwSX+QdUE71qT+Q/eWL/qGV+m8R84Gd5lsS80Mqze8S+sAQ6UP6gdSP
9AWpr+C7oZ/0Pxf+QBf5I+p5wE/+kb8g/SX/QfoveF9QRvsheH44p/0RvADE
037R/kE67d8/voNa7w==
          "]]},
        Annotation[#, "Charting`Private`Tag#159"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk0oRFEUx28mShazGixslIgioUg4SilLlLIg+ZZ8jGRKlCnJoMnHAsOI
HSkLimahYxrJyMdDiZKvpzGTaZqUeuM90rx77lm81+3c+zvn/P8ntbmvpi2G
MZbJGIv+eYQxo2TvZi2sYbseIUyoUmu7/BpenEcjiNJHz/fflYb5enxi+a75
lG1q6FiORgC7KnoNFrOGnOdHNHW7z7IFz4c7zu2BwycVddz5O5oPjrIaJ1Ti
yTg8df+rpavEe0V5xepM8fwQ7wW/ijvqmxt+6P0jjuUM2seVCC7p9x/QmCg3
FS5GqN4duqdtdUklEczT+bfYev1mmAsoxJNwv8wxc7yh0HsvlsZ/DLe0K5ir
3/fg9kL10GSRyLtQGnm22ZMVnNXPW3g/Ou8zxAkeY7H6V8F1ngeJ8vzsgkt6
X8T5IPg874Uyqk/9geivgPcPbdR/J58PxHyrfH4w0fwS1wespA/pB0I/0heE
vpwvg4X0v+T+QD/5w+v54IT8I39B+Ev+g/Cf8z6hkvaD84JwQfvDeSEw0n7R
/kEa7d8/fnxbfA==
          "]]},
        Annotation[#, "Charting`Private`Tag#160"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl8oQ3EUx68ppTzwoCiFl9XetInFw3mhPGrZi6JMQ1KeKKI888DTsqUh
UasZWa1WcpQ/tYytzI1aoa1rs2u/bWwjHrT7O7/zcG+/zu/3Oed8v6fdNmux
6yRJMkiSVPnzyOG4MT4SUxhOaJHFvH1e/lMY3oYroeJJXQDm3hiatMhgccXt
7kkxdDkrkUaffN0wkGbIeSn01a8VHO+Cp+CBYbK6VWWo4cJJ7B6r8cofgpfA
pUtrv58J3is2Jc3LnrzgveBesy5z+Cnex/G4pc0UKDLc1O4/oWE4vnpaFvVk
vNk6U2M/DI0a/x7Pner2oJQjXhRrY4/WYDJH70P40KhEjUcF7NDuX2Bi3b9w
5f2ifBB7I78zhukSbmhnD1r0+65RRxmFglXa9xt3eB6GKM/PQeij92bOh2fi
83wIIlSf+gPRXyfvH0T/U3w+CNN8W3x+0NP8Ua4PCH1IPxD6kb4g9OX8BCyS
/nfcH+gif3g9BXbJP/IXhL/kPwj/OS8DJdoPzlNB7A/nZaFA+0X7Bzbav3+o
cmab
          "]]},
        Annotation[#, "Charting`Private`Tag#161"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8ow2EYx3+YUlyI4qC4YGnRKIp6chMH/1IOOJClmUg5uLnOxXIQQ7nI
31AOGsv3ILQMKzYUi5kh2k9oKxba733e5/L29rzv53me7/fJ7xpo7klUFEWv
KEr8FPGOCVt1SveMCpMWYfQ11h7pZlWcuOPxhlTrWFJoTkWZFq8IeDK83/Mq
7NPxeMFQm9NZsqBC8J4xmr5aZF6RvBAMhc0G66YKDecOIie3eNi0LXkPCLY3
DV7uSd49KiwdgfVDybtDZl2/Eafy/w0MeTuffp+KKe39NXSNgZOIX9bz4bbP
HGt5UmHU+OdwdiwtpsUkz4Pki6tWR/Cd/7twkRXyGDc+UKq934d3fGvkYO2L
8w5Unf1Y9OYIbNp9GQ0FC/bOySikgr9/8YhiXuSpnvPi7qAa/l8p+ORnvsi7
6Jjrc38k+ysX/dMu998r5iM536yYnxJ4fo/Qh4pZH9aPpH6sL0l9Bf+BHln/
U+EPZbM/ol6ICtg/9pekv+w/Sf8F75XkfgjeG8n9EbwwWXi/eP/Ixvv3D1xk
X04=
          "]]},
        Annotation[#, "Charting`Private`Tag#162"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8oxFEQx19uLi7O2/pTysrfXaEwtFxoS5I/tSciDkhJKCl/ThzsQaFd
KRwcRGkPq9UcXGzY1pKNVv6LrH0uDhKr/c3MXF6vee8zM9/vZHYONnenKKVy
lVLJk+IT61r0761JY48RcRxpmuprNGs8PUlGDB9q8ndmsjVajXjH8MFm+pBF
48pyMt7w+mMs9GTVSLxXLPBbqjZAeC+YEk4b6HZoNHAnT3iojx1hp/AeMaP0
u36uX3j3WJ3j3bdMCu8O57q8ZQ0u+R/FjgvT/Py6xiXj/RXa9oan/F6pd4mz
8cXExJHGEoN/jtHxkurpmPBCmNdenBX5kf8BrPXsmod+NRYZ7w/R0+Jqc/1J
3oeF2yroTGhcMO5b6KmsMEcSwlMqlXVcozyscp7uPsjn/+XEBzfzKR8AO9fn
/kD6s1H/cMP999J8MM3zuWl+kPlDpA+0sj6sH4h+rC+IvsR/BNE/SP6A+EP1
XuDrjPxjf0H8Zf9B/CfeO4R4P4gXg2feH+LFYZT3i/cP7Lx//7hVVfU=
          "]]},
        Annotation[#, "Charting`Private`Tag#163"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8oxFEQxx8lcdmTw1I2fy5ayb+DkoaNopTCjYO2yEHLtheFQpSUcrEh
IiK0KXGwB035c1CWjRBJtBJ2e2+zyd9F+5t5c3m95r3PzHy/k2HvrG+NF0Lk
CCFiJ0UYuz76PXMOiW1GSPQ7TcPZTom+o1iE0HbgsSx2SywyIojuc6s5NCRx
eioWz7i1Xn65MSGReE/oG2pxj65p3iPO7CdWR3YlGrijB6zIPKlpuNW8AObV
DZjjfjTvHjdtjX3VaYp5d/ht9S25ShX/v8Ede+7LTZPCSeP9FQbGW1+zehXX
u8DUSHpx46zCQoN/hktuy8r2qeb5Mbkg+GtX+v8hit2U64M3hfnG+z38rF2I
Vn3pvBfDqqPHFVU4btxX0WkaHGv+0zwhkljHecqDg/N094Lk/yXEh3fmU/4Q
Erg+9we6v2LqH5a5/3aaD/R8MzQ/6Pn9pA94WR/WD7R+rC9ofYkfgFzW/5j8
gTL2h+o9wgj7x/6C9pf9B+0/8YKg94N4Iajk/SGehBPeL94/cPL+/QMKZVvK

          "]]},
        Annotation[#, "Charting`Private`Tag#164"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kjtIglEUx68uRRD0WCOxra2HUvQ6PVzKLWipqUiLIFqyoddcDSpBVFai
RUMFPZbA6QxNhpppiVZQYYnx9X1f5FAkVPjdc89yuZx7f+ec//8YR6b6bXrG
WC1jrHDy+MCb2OBHpVNGuxYKti52VelWZQyHCvGOvam96MmOjI1aSOg1DlgS
pzJ6Ngvxhq5YtT9/KSPnZfGzxWSekwQvg8nZsexSuYIaLvSC9lRO19SmEC+N
e0vLMwsTCvGe0Tl95ujZUoj3hI5688pkWPx/wLJIX/z7T8EN7X0Kb3WPNdYG
leol0O9+NSdtKjZo/Dh2unSxo2OVeFHMG9cN53cq/Q9isTTUrn9TsU57f4He
tfsrQ07kA1gijcYsPyq6tfsBWr4O592/gsdYEeno43nopjy/B0D8b+Z88BCf
54NQSvWpPxD9mXj/IPof5/OBj+bb5vNDnOaPcn2ggvQh/UDoR/qC0Jfz07BP
+ke4PzBM/vB6Gbgm/8hfEP6S/yD85zwJdmk/OO8drLQ/nKdAB+0X7R+I/fsH
BkhbDg==
          "]]},
        Annotation[#, "Charting`Private`Tag#165"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kj1IQlEUxx9CtTQVQmMWgUVDaEMtHmwpKAiEhIaWRBEyIgqJklBJCFpe
RFDRENjS0hA0GMShclAwkT4NtBTFNN9HSxhRGL577lkul3Pv75zz/x/D7ILN
qRMEoVcQhMbJ4hPfMsm1mE9ClxYKLkdXsnNBCW8TjZCwGNLPm3YkNGtRRd/F
uv3sVMKD/UZU0N8ZGLM8SMh4Zazpx1s+dDLxSuiJNSXFYRk1XKKIIz2e7axX
Jl4Bj7+vF6ciMvHy6MgWZpx1mXg5tFqiRu+oQv8zKDr70m2ignva+xcMZbau
7GmF6j1hfvexo7VLRZPGv8fEtNnv9qvES2HCWCtKlyr9j2Po3FXvf1ZxQHt/
g7aJctlQ4fkI/rY7uu++VBS1+wkGJ8Ow9Md5gtBMOh6xPAQoz+4R+KH/Q4wP
nM/ycdik+tQf8P4GWf/A+3ez+eCV5jtk88MGzZ9i+gDXh/QDrh/pC1xfxi9A
mPRPMn/ASv6weiVwkn/kL3B/yX/g/jNeFVZpPxhPgnfaH8ZTgO8X7R/kaP/+
AWM7XBE=
          "]]},
        Annotation[#, "Charting`Private`Tag#166"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8ow2EYx3+0TckOO8gcHDgQSRoHtfKsKDYHciCXTcM4CDm4kouU5LY/
aSmlllIoWg7Pag1jm0lWahZtren97ffDWUv7vc/7XN7envf9PM/z/T6t7tXJ
hVpJkjolSaqePL5xvm7X5LIy9Gih4EM0sqgfYphMVENGL9ZY7mcY9mnB0OFb
N5g3GQb81fjC7Y0rXf0FQ84rYXJsTu/8EbwiNtnc1h2rjBouUcDGV4fzel8m
Xh5vzrpjckkm3icOhisx3WiZeB/o6rAHM6Ey/c9igRmbPQ0K+rT3b6g+brG1
FYXqZdA4exr7fVbQovFfMNdzxyojKvHSaN6znXT5Vfofx/NM2/J4RMVe7X0U
A46p4ERW5MN4mzsebvlW8UC7hzDVPu3Q/wmeJBlIxyOehyfK83sYYvR/gPPB
S3yej8Ml1af+QPTXz/uHd+p/ic8HYr5DPj8oNH+a6wN50of0A6Ef6QtCX87P
Q4T0T3F/wET+8HpFMJF/5C8If8l/EP5zHgM77QfnyeCn/eE8BVK0X7R/4Kb9
+wfML0/Q
          "]]},
        Annotation[#, "Charting`Private`Tag#167"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk0oRFEUx2+Tj70a02TEkGKHUVjoFAsbKXbKQmo0U2Kht9CEqbFTPjbT
kGJBUhYk+Vg4SWg0o4mhZMQgee/NzENKpEbzzrlnc7ude3/nnP//OPuHu90W
IUSNECJ3Urzjg7FqTJ2rOGBGBh0j3kN/XMVoJBcpVJYqfeWfKrrM0LE+frKz
WaHhwnwuVHzy+q3CrSHx3rDIl9c3tKsx7xWdycKNb5uOJi7yggfBqrvWSZ15
z1gcOk1s/+jMS+J1tsQdUFLMe8S2rNeT/Erx/wTarZeZBiWNIfP9Lbbc2/Wz
rzTXu8FSu2VlVslgvcm/wpnpxuZAvsG8GDZ3ax/BQYP/hzF65OtUVgysNd8f
Y7ZjbWwrIvP72FPWNVetGjhr3tdxwj9R1/4reUIUsI7LlIdxztN9H3r5fxPx
4Y/5lA9DjOtzfyD7a6D+YZr799B8IOdbpPlBzh8jfcDG+rB+IPVjfUHqS/xn
cLD+F+QP7LE/VO8VpH/sL0h/2X+Q/hNPBxfvB/FSMMr7Q7wMyP3i/YNb3r9/
mYdXmA==
          "]]},
        Annotation[#, "Charting`Private`Tag#168"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kj9IQlEUxh8NDZJLf6gxqaCIIErJWs6kRDUVUZBQRIYh9HLJEJpCKCJq
y8TB1agIcrGhAzWUZilEhdSgaPaePn0OIbVU+O65Z7lczr2/c873HcOiOGmv
EwShRxCE2smighe/h6eNvRIua1FGd6y9Lzgk4UO8FgpuWl2RH5uEg1oUccEw
5jX6JfQf1UJGt+njL1GSkPEkDDd7SzgtEy+PSkj0eBIyarh4DjOdYYdutkC8
LILN8tWlFIiXwbdPvTixXSReGjtm4nKlW6H/7/iqC+/fxhT0ae9T6Bxx6/ec
Jar3gndT1h2loYwDGv8JW++rK/pImXhJnN9tWpszq/Q/imempeeTLRX7tfc3
uHoVGB2/5PkI+q9dUjWt4oF2D2GuxX48/K0iV7CedAyyPGQoz+4R8NF/M+OD
SHyWj8I51af+gPdnZP1DG/XvYPMBny/A5gc+f5LpAynSh/QDrh/pC1xfxs+C
hfR/ZP4A94fVy0Oe/CN/gftL/gP3n/GKwPeD8RTYoP1hvDKs037R/gHfv38Y
cFfr
          "]]},
        Annotation[#, "Charting`Private`Tag#169"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kj1IQlEUxx8OEoHQ0lpENDRVfkCLnSFqiFra+0DIQogGo9khGkpIiMBK
IqQic6iEKKcjSJigIUlGaFQY14/3fE/ICKMhfPfcs1wu597fOef/Pz2OlekF
gyRJ/ZIktU4edYxbu6/iMwydeqiYD17HzMsM06lWKFjxDPx0HTC06CHjuRSX
FxnD/b1WVNA14B6xTZWQ88p4OtT7a0iXiMewjNaniKOMOi71iTtN5g62V4hX
xMDYxVwiViHeBx6HRo1ZT5V477huy0vOcZn+F3CiYbl3mRT06+9f8LbNdPn1
qFC9HJabZ9kOfw3NOj+LdpdxPupQiZfBzruaN/in0v8kbhdW14yzGg7q7+OY
bSTrfSca5aO4ET4Mbz1r6NPvIbRHdjdfvzUUChpJxyOeB5Hn9yiI/8OcDzni
83wSfFSf+gPRn5X3D6L/JT4fMJovwOeHG5o/w/WBSdKH9AOhH+kLQl/OL4Kf
9H/g/oCX/OH1GLyRf+QvCH/JfxD+c54MIdoPzlOgSvvDeSoUaL9o/yBB+/cP
3RJdMg==
          "]]},
        Annotation[#, "Charting`Private`Tag#170"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx99WZsQFLSIr4kZuZJKbOTcuWObCHTcrIlcoJVaS5EJhI8nH
Jm42lHI7H/2LpNV8NKWEGvvANhtJudTec95z8/R0nud3zvn/T1XvcFe/TlGU
WkVRsifHF5yFvlZHXxQDaqSR7Ki0F49FcRXMRgrrOfrf/oMozGokcTYx+1hm
iGFjPRsfMEwWj/7OxMC8d3RuBea+TXHhxfFnmTbaQnGouGAUdmP3q8/9JrwI
Bk0jRTXj78J7Qbcn79ll/xBeGNamzQuvLSH/n7B5qAsPWZJYU98/oD2Bnfq6
lNS7x35JtbOg9BMNKv8O+YsjEa8uLbxbTE85Qqv+tPwP4CjkvFkxZ1Cvvj/H
YqNj2bqQkbwfx/uTp4lgBi71vody6/yl+ScDTUG96LjNeaqQPN/9dCr/m5lP
88LnfIBOpL70R1p/jdw/5Ur/gzwf7cp8bp6f2mT+W9aHPKKP6EeafqIvafoy
P0Ka/tfsD/WIP1wvTkoL+yf+kuav+E+a/8xLEmQ/mJcij+wP89IUk/2S/aMl
2b9/I49Ksw==
          "]]},
        Annotation[#, "Charting`Private`Tag#171"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx1+fk5oL7YJEWU2WlNiFmzlXvlJiKy6UtPJVsogVLshHzZ18
1CzJjQu1XXChVtohUqv5SmRSY2M2m70uFC5Ie895zs3T03me3znn/z+lFqup
N12SJL0kSamT4gM1+r2GImMI+5RIYqXry6Y1h/DMn4oEHhjcAfdqCGuUiOOu
IziqlcLoXE9FDIOnusLgchiJF8XuuXl1a/Mz8yKomtGM/5a8oILzP6P63nPj
zYswL4ztF5OD5/mvzHvCtk67JksXZd4jLoz8TRdDjP8/YH99xWFZ1xs6lPcB
3DCXxybG4lzvFjvr9mc/FxNYrfCvsXFzYvvH8c68S7xLBLwWa5L/+3Cl58Q+
lCljlfL+GHOvvoePR2XOezDHlTFTcCTjknLfwanPFpvxQ0ahYDbruEV5EHm6
e0DF/2uJD4JPeR+scX3uD0R/Buofmrj/AZoPOni+DZofnDz/JekDVtaH9QOh
H+sLQl/ih8HE+p+TP5DG/lC9COSyf+wvCH/ZfxD+Ey8Obt4P4iXAy/tDvCSI
/eL9g3zev38IzUwH
          "]]},
        Annotation[#, "Charting`Private`Tag#172"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx99WVsKdMilyobhbZk1cHLcUQhrFyuQjJfckSna12lbKZ1lx
s1I+byacC4nJx5CxEu/sNWafCheUtPec59w8PZ3n+Z1z/v9Tah1p7dNIklQh
SVLmpEhj3a68X373hP1qJLG7a9zQnCXj+Vkm4lhilHofW2Q0qBFDx4un3Hop
48J8JqJotx2snYyGkHhviA7L9HPzM/MiqMsPGSfqw6jizhScmZo6dvUozAuj
3a1ps7hemBfC4eXc3u2rCPNkvB3NU0xFb/z/Acd1HUOv/VGcU98H8W8v71O7
/s71Anh/tJGjpGNYqfJv8MucXRcsSzDPjwWBFUVfnOT/PtycHDCt+pOoV98f
oremIbLYnuK8F5s6J64Ld1LoVO8e/PpInP7GUygU1LKObsrDN+fp7oVG/l9N
fBB8yvtgi+tzfyD6q6L+QfQ/SPNBkOdbovnhh+f3kz4wxvqwfiD0Y31B6Ev8
MDhZ/wvyB2bZH6oXgVL2j/0F4S/7D8J/4sXAxvtBvDiI/SFeEsy8X7x/UMv7
9w/AZVYI
          "]]},
        Annotation[#, "Charting`Private`Tag#173"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kktIQlEQhm8Py520SnpAD8KMMLEiwcUQLVy0StxHUWKgphCEu5CIVhGh
oiIVVJBFQbQoVwMFgmQmBEEp5SNN8xUkQYsgvGfubA6HOeebmf+f3vll3WIj
x3FyjuPqJ4svPPQ4J6/eXtDARwX3zF2ajs443kfqUUJ3i6P54S6Oo3wUUSda
vXGUE+jz1qOA3tljU4/9FRkvj0uWcsOaKkm8HK7IohKnLoU8LvKOP7Gm35gr
TbwMDrZrL6y1DPFSuH6m3eg3ZImXxKBM7Dekc/Q/geebxnDrXB49/Ptn/JTb
B9riBar3hFmJ+vpvuogqnv+IGv2l0hYoES+GNumBYjhUpv9h3OoWT+k9FVTy
729xJLRgTY5XKR9Ey45ZUjuq4jZ/D6D7u09qLVRRUFBEOu6zPLgoz+5BMNF/
NeODgvgsHwahPvUHQn9jrH+YoP6NbD74oPn8bH4Q5o8xfeCE9CH9QNCP9AVB
X8bPwBDpH2X+QJH8YfVyYCX/yF8Q/CX/QfCf8YowQ/vBeCXw0f4wXgVOab9o
/2CX9u8f1HpIyQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#174"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kjtIglEUx79eGK0O4eBgRiAiiYUUFQdqagiiIQKXCkqhoc2hyQpqyKIG
xfpKKgkJc3EJQThENAhmQmlZka98lM/NCInwu+c7y+Vy7v2dc/7/o1hcnVlq
5ThOxXFc82RRw0a/uiNhi+KyEBWUK/t6fPEo3oeaUcJa9Max4YrhgBBFlFpl
3vnKMx4dNuMLt+dy03pfHBmvgE6DpdTIvBEvh1bVb11i/kABF/rEA16i1V0l
iZfBtcB1t3s0TbwUBhILLal0hnhJVGt2e+S2LP1/x9r67GtyMo8O4X0cx6fa
PE8/BaoXwy1P8WSF/0adwH/Esd6Rh5qyRLwI7t1lNRZjmf4H8czCh+yGCmqF
97eY36zbnNIq5f1o1Mu6vPYq7gv3S7x4cYf5bBVFBdtJx1OWBxfl2d0PJvo/
xPiQIz7LB+Gc6lN/IPY3yPqHYerfxOYDcb5jNj9M0PwRpg+USR/SD0T9SF8Q
9WX8DJhJ/zDzB3bIH1YvBzz5R/6C6C/5D6L/jFeETtoPxitBg/aH8SqgoP2i
/YM/2r9/gWBYTQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#175"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx9+0mgtX3ElsdqXmI6wkOsnNWEm4IaWEhJCyLBIpkpLPfKSI
Cyntwo3cOCK0GjbzMYu8s7Vebd65Ii6kvec85+bp6TzP75zz/x9ja19de5Ik
STmSJCVOik+0WU6qmr9vsEMLFXPL7HK/1YNX7kTE8GAxVus3e7FIiygafmG0
ZucW19cS8Y6GfPlnf/sOiafg4mbNkiPzkXkRHKrcs5fqA6jh3GHstQS6g9Uv
zAthmt18sdslMy+IE2O67GHrG/NkHHc2K96iMP9/xulLvenaGMFV7f0TGixf
jvlkhes9oD8+ONDy+o6FGt+Hpw2HMLMcZZ4HjU36tsakD/7vwtn6v5WpdBUL
tPdn2O10K2FV5fwR3vv0KbbJOM5p9z08z3KOjAXjKBTUsY5blIcLztP9CMT/
EuJDD/Mp74IFrs/9geivmPqHY+6/k+YDMd8GzQ8ZPL+H9AGhD+sHQj/WF4S+
xA9BKut/Tf5AJ/tD9SJQwf6xvyD8Zf9B+E+8KJh4P4gXg0PeH+KpkMf7xfsH
5bx///3STWk=
          "]]},
        Annotation[#, "Charting`Private`Tag#176"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kjtIglEUx78eEjQ0OEiIIDZELSJlJDUcTGhzcWhoCJEMK0qEoKWpFwgV
TWUaFVRDUbS0SOBBk8xQMR+BYGD5KNO0JaIHEn73fGe5XM69v3PO/38UJqvB
3MhxXDfHcfWTxQcqHGMGe6cfJ/io4Mi0uLEQ82M4VI8ybvx5D/3xG+zlo4RS
6/GyU3aHzp16FFF5ZmpIOyLIeK9oWdQODElixCvgnivVMTmaRB4XyuG3Si91
NaeIl8XAvsgzWEsT7wnvp7p0K9sZ4mUw3ye/qnme6X8azT+n48piDh38+xTa
uLxhrfWF6j2gXaK1iduL2MPz47jedmScr70RL4ot59xSfqtM/4Poc1x+6ZLv
qOLfX6NPlvj1BSqUd+NnWR1LzFVxk7+f4KxeE5Y/VlFQsIl0PGB5mKE8u7tB
+K9hfPASn+WD4KX61B8I/alZ/yD0b2HzwSrNt8vmByvNH2X6gJH0If1A0I/0
BUFfxs/CLekfYf5Aifxh9QpwQf6RvyD4S/6D4D/jlUBE+8F4ZVig/WG8CgzT
ftH+QT/t3z8vXFAF
          "]]},
        Annotation[#, "Charting`Private`Tag#177"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx98QF/IRN0pIkdxIyOzqXNHkxkcohVoj0RJuVgutZLJaIsWS
vVyQaM2Fiy3tlOViNZqPfNPWWNhr242PckF7z3nPzdPTeZ7fOef/P6Xa0faB
FEEQKgVBSJ4UCZw2LG3ufjlwUI4Ypv9spdl/nXjiT4aE+/rZr/yJA6yVI4rd
ekuW5/gQbavJeEPTmZCIaL1IvFc0ZjTt6Ww+5kXQPHXX3DIWQBnnf8ZMSSOW
mC+ZF0Z/bv/yxOcN80KoznabqjYemRfE6orF3lJViP8/4PVM7rhODOOK/P4W
y8prHDl/L1zvCu1uU+Fx4yvWyPwL1E+2HsT73pkXQENVvdhRLvF/H3rynO53
ywdWy++92PUU7Glej3HehUvWovk2bRwX5PsOqq3DZuNNHBUFU1lHkfKg4jzd
XbDI/xuID53Mp7wPjrg+9wdKf3XUP4xw/0M0HyjzrdH8UMzzB0gfOGd9WD9Q
9GN9QdGX+GG4Z/1PyR/4jpI/VC8Cc+wf+wuKv+w/KP4TLwoa3g/iSbDN+0O8
GBTwfvH+QT/v3z/hAUxw
          "]]},
        Annotation[#, "Charting`Private`Tag#178"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8ow2EYx3/+pO2gHDgtSU6ctCG7eHLaiYODgyRN5CBKVooUNyErkT9r
tlI4EBda4ZF/WWab/BpDxqzftvZPXISk/Z7nfS5vb8/7fp7n+X6fcvNAS3eu
JEmVkiRlT4p33LW0PJ9/r0GPGmkMB8xDA+tOuPZkI4n5/rmrHO0sGNRI4J/m
uG4tZcXlpWzEUWsoLDTZt5F4MTSMlVQGig+ReAqebfeHmlYuUMV5ImhZde4U
b/iQeG8of51aug5k5r2i1jSus8WCzHvBZ83C6LAxxP+fsLNMLro3hXFRfR9E
41h0pE+JcL0AOu2NoaPeKOpV/i1GlNIm/X6ceX7ca39sk7cS/N+Nn9M+na0h
hdXq+1MMnVRMTA6mOe/CX43de9mcQat638SCV9/M/G0GhYJ5rKOD8iDydHfB
D/+vJz48MJ/ybvjg+twfiP5qqH8Ic/+9NB84eD4bzQ+1PL+f9AEz68P6gdCP
9QWhL/HfIMj6e8kfaGV/qJ4Cw+wf+wvCX/YfhP/ES0AH7wfxkjB1Q/tDvDRU
3dF+8f6B2L9/FSxQig==
          "]]},
        Annotation[#, "Charting`Private`Tag#179"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx1+mbUpyodZKsVygXMzHhdycWjK1RD5TiikiShRFiHLlSqJG
knxkKImk3ThDZLL1lm3lq229GmszbuxCifae856bp6fzPL9zzv9/DF2DDd2p
giAUCYKQPCm+0FrYtep1XUCPHHFsrP/2DQTOwX2XjBh2aK0RyXIGZXJEceo3
P/u9/QRWlpMRwT5D1sJa4wYQ7x0zV1Lq5tJsSLwwDuW1tJmvTlHG3b2iJeHe
S3+8QuJJWDt6ODnbJCLxQlhq3z62qf1IvCC+6ezDB8En/v+M1ZEcTyIQRJv8
/gGN6tDej1Pien4cv849rJ0JY6nMv0evSmuf1kSYJ6Jf95xYNkb5vwtvMpxH
Yx8xNMrvL3GroN+3VBXnvANLdja3TJWfOC/fd7FVv/gy6PlERUEV67hOeWjm
PN0doPyvID7sM5/yLrjl+twfKP2VU/8gcv+9NB9M8HyrND8U8/wi6QPA+rB+
oOjH+oKiL/ElqGH9PeQPmNgfqhcGPfvH/oLiL/sPiv/Ei0In7wfxYvCnof0h
XhzMvF+8fzDC+/cPjB1KSA==
          "]]},
        Annotation[#, "Charting`Private`Tag#180"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kt8rg2EUx9/YBZIrlJuNNYobwoVycdxywSJ/AJqmrF34sQtF7MINvZIf
7+TCSqJQoiTlJNZ6axirZcUYs72z9ZKrJaS957zn5unpPM/nnPP9nqp+Z7ct
TxCEWkEQcifFJy4ZF+MOZxAGtVBxxGJNFkRv4CqQiwzW/brFSCwATVqkccqN
qvDrhzVPLlIop/a95s5zIJ6C3+1hsezvgHkJbO0pKvTOuVDDBeJ4/OVTTF3H
SLxX3D4rHz6d9CPxYug1usbGf26ReM9YuWvfFGz3/P8BQ8sv9qG7KEra+wjG
LvtHK8QXpHphnHnOenziGzZq/BDWmJOSyaowL4iGiSfH/d47/5exz6rYtqQM
NmjvLzBuqF+dLlU5f4KPHUcuv+UDF7T7Dn6XHM4Xyx+oK5jPOm5QHrKcp/sJ
RPl/C/EhxnzKyzDA9bk/0Ptrpv6hmvu303wwzfOt0/wQ4fmDpA9csz6sH+j6
sb6g60v8V/Cz/tfkD8yyP1QvAWH2j/0F3V/2H3T/iZcGifeDeBlo4/0hngq9
vF+8f7DC+/cPI79RJQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#181"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1klsow3EUx//hUZLLpOzBw/9BHiwbyYOjhlyi3PKwaBbLC/NEeXArzyyL
udQmpZSUB0XoPKxhzFqG0dRcluv859Gtpf3P+Z+XX7/O7/c553y/J99kaelN
EgShQBCExEnxie2HJTbDfhDMckjoWFo1tWmCcOZNRBTbDc9TG9OXoJXjHZvC
6fG5yDksLiTiFa0rIzm2MR8Q7wUPNXG1OOhm3hN26Z3i79o2yDhvBDPrrr0O
/QQS7xFTvjMOsn72kHj3GB46URfOnyLx7nBnS7dpP7pA+n+L2pe9jdzjENrl
9zfYoKoaLGq+R6p3hWFJ1zpui2CxzA9gucsvdlifmefHr9DfsFt84/8ezLak
dtZURlEjv3dhjzQQNj58cH4XG0ONKmNaDGfk+zpOtKl9/a4YKgoms45OysMo
5+m+C/X8v4z40Mt8yntAqc/9gdKfjvqHUu6/j+YDZb5lmh+qeX4/6QN5rA/r
B4p+rC8o+hL/Ecysv4/8gcla8ofqPUGA/WN/QfGX/QfFf+K9QzfvB/GiUMH7
QzwJZnm/eP/AxPv3D59HSTc=
          "]]},
        Annotation[#, "Charting`Private`Tag#182"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kklIglEQxz+KsOgQhR06lSBEhyDKQxA0hwpsOUQEnVpJsYWKoItRtxaI
aAFLo1I6RHkQsksectqILI0ykBZLRRHNpQ5R1/Cb+ebyeMx7v5n5/0cxMN6h
yRIEoUIQhMxJ8Y05nv02eXMAtGKkUS7DtfyjD/C4M5HE4dCb3Zr0Q40YCXxr
6drPkb3ClikTcWyM6RcbinxAvBi2mnWFFeWPzIuiZrDSnL65BhHnjqBiZsg5
f3LMvDAWnJ07ZTsWJF4IMbdy4vbzAokXRLuq88qW94j034+/Jd3t2XvPaBTf
v6BztEVvlQWR6vmwX9nj9a+EsVrkP2F9U0o7eRdl3gPuvhuWjcY4/3ehdanv
ZzaSwCrx/SWaNrTraluK8w5cmC61Ff+lcVW8H6La640aTr9QUjCbdbRQHqQ8
3R0wx/9riQ+bzKe8Cw64PvcHUn8q6h/quH8dzQe9PN82zQ8Onv+B9IEk68P6
gaQf6wuSvsQPg5L1vyd/YIz9oXpRmGL/2F+Q/GX/QfKfeAkI8H4QLwkjvD/E
S0MZ7xfvH0j79w9A8Ue6
          "]]},
        Annotation[#, "Charting`Private`Tag#183"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx998FSUXxAURrYWrhdDEKRe0lJrydclM75WPC1Irk5JQPm9G
NEotSpILreQkkXeNCNPKtO1lWeNF7qSlvee85+bp6TzP75zz/5/i3sE2a5Ig
CGWCICROii8syVx2D83I0K+GgmXZ5b91NTJceRPxjh35ReJWYxgq1Yih77gr
13kQhLXVRETRDI5QZkEAiPeG23t+adzzyLwITpxYSv0Lt6DivC94b60fydKf
M0/GlN2KvNM/F/NCqHPMKUsfh0i8IDaJoien24P0/wmN6S1mY88DOtT3fjQd
2iJxawCpng+b51OjDZNhrFD5d7hqy+jD+CvzbvDNtyLPpkX5v4T3w9790akY
GtT3Z7hhKehsHfvgvBsn7YWX388KLqr3HZRcP9XTR5+oKZjMOm5SHi44T3c3
2Pl/LfFhjfmUl+CW63N/oPVXRf3DCvcv0nxg4vnWaX6o4flvSB8wsD6sH2j6
sb6g6Ut8GQZY/2vyBz7ZH6oXASf7x/6C5i/7D5r/xItBgPeDeO/QzvtDPAV0
vF+8f6Dn/fsHxMFFCA==
          "]]},
        Annotation[#, "Charting`Private`Tag#184"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx98wN4oUF3OnRWmRNhdK6yjKlYuRK5QstgshKfm4JfKREo3I
R7Eo5evCUEckW828iGUtGa/3NWOocSntPec9N09P53l+55z//+Q2d9S0JAmC
UCAIQuKk+ELF21nfN6pAqxoxdP2E4opJgQtfIt4xO8vobDDKYFYjiqJ+5bG6
X4K52UREMIjTaC18AuK94u/A4Nve4gPzZKxaHpF2IgFQcT4JR3UnnTPNIvOe
0eBvyj/qOmZeGBsrXnY2PT1IvEecio+162wnSP9D2L1w6A6nXqNTfX+Pp/KQ
WOsKItW7wzL7lZTeFkaTyr/BDHPe94TxhXkiHiRn2gIdr/zfi6vWwqI6QxSL
1fenCLe+8eHyD8670Z7TW/l3FsNJ9b6Ol/vn5srtT9QUTGYdlygPWp7ubmjh
/6XEBwvzKe+FNa7P/YHWXwn1D2ncv4PmAwvPN0/zwy7PL5I+4GB9WD/Q9GN9
QdOX+M+Qwvr7yR/YYH+ongw29o/9Bc1f9h80/4kXBQ/vB/HeQc/7Q7wYbPF+
8f7BJ+/fP1RiTQM=
          "]]},
        Annotation[#, "Charting`Private`Tag#185"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx5+k5IZLKYq4IBcblrarc6Epi9RoPm7kc7tBrtzIBXIhF9oF
I0ooX0uRj17hhJRlY1iTkoYZttmUEBHtPec9N09P53l+55z//2Q2dhhb4oQQ
uUKI2Enxil/tmKxZCEGrHBEMJL5lpxpC4HLGIoxW/2xPuioIhXKE8GMgqy+/
/gnGx2LxjFrDUf/awwMQ7wkPN0U07/yOeQEU66MN2HEDMs7px7K50qHtOi/z
7rHXmjG2rDpm3i2OvDfvi64V5vmwtmHJ9G1eQ/p/jcHVTpspx4U2+f0VStMz
ldWeS6R6XtzodhZJ5T4skPkXWK1LGdQY/Ug8Nwq1fnLL88j/HVhjb0sr3g2i
Wn5/gNtnmpKkhBfOS6jbs5j09ggOy/cF/K3YMZ8uRlFRMI51nKI8/HGe7hIo
/7XEB4n5lHeAietzf6D0p6H+oYr7t9B8sMnzTdD8MM/zu0kf8LA+rB8o+rG+
oOhL/HvoZ/1PyB9oYn+oXgDi2T/2FxR/2X9Q/CdeCH54P4gXBmV/iBcBL+8X
7x988v79A5qoQ6E=
          "]]},
        Annotation[#, "Charting`Private`Tag#186"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kktIQlEQhi8S7VoUBbYKIbAHQVhCkDBE2yCodFMQFEW4SNJaRIu20YMy
kB64aNHGRRRZC0kaKIhMjcywB1KaaV29XQ2EFkKEd+bO5nCYc76Z+f/RjdkG
JjSCIDQLglA+KQoYnZttaUjmYVIJGcPTaB5cyEM4VA4JC+GcydYnQ4cSOSwe
1TUmhyXY3SmHiOKWPhg7FYF4X3iy6fLmrRnmZfBlaUi+X38HBRf6wFLwsNsy
H2deCtMB97W2Psq8JB774EzvuGBeAg3nn/PL8irS/zhW+WPpg9or3FbeP+Nb
9YpXKz8g1YuhU2zrGel/RYPCj+K3Zq2t0pFC4t1h8Wfcbzd+8v8AesbMTVZL
FtuV95f4Z/cbf4MS532YNGUWI04ZN5S7B3W9ozOt+3lUFdSwjnuUBzVPdx8k
+H8X8eGX+ZQPgFqf+wO1v07qH7Lc/xTNBy6ez03zQ4LnvyN9oIL1Yf1A1Y/1
BVVf4qfghvW/JX+gJkT+UL0MPLF/7C+o/rL/oPpPvByUeD+IJ8EX7w/xZHjk
/eL9gwjv3z8QXFGD
          "]]},
        Annotation[#, "Charting`Private`Tag#187"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx1+zm9241O6kllouyNfc6ExcaLnycYVdqMmF0m6W0iiTJd+K
RlvcIheGGOkU+Vg2kfK5ZBtv+zKmKYWlvee85+bp6TzP75zz/5/Czt4mk0IQ
BK0gCNmT4gNzWuynd+pP6JIiiYZQVZ89lAK/LxsJ7F8zPEX0KSiXIo677sb+
tO4DFheyEUXlw9BIq/MNiBdBiz3XequOMU9Ep/K4wPrzChLO94KjGvVmvjHI
vDAute8ZivbvmBfEqLfSVWLyMe8Zz09uxG3NGv8PoHk7T3W2eoAO6f09zuwY
ExtfV0j1brDG5vYfph+xTOJfY/FYh659MoTEu8SA/tsMsyL/92Km5/czHY9i
qfT+CJXztvW2qQTnPRgz1U6sW5I4Ld1XcEBVp2hzvaOsoIJ1XKY8yHm6e0Dk
/9XEh8wc8SnvhR+uz/2B3F8F9Q9a7r+b5oN6ns9J88Mgz39J+sAw68P6gawf
6wuyvsQPg4P1vyB/YJz9oXoibLF/7C/I/rL/IPtPvDjs8H4QLwFW3h/iJaGB
94v3D/6aaf/+AQnITeI=
          "]]},
        Annotation[#, "Charting`Private`Tag#188"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kstLQlEQxm+XFq0y6h/otYkIooLEFrNz5aYokFY9JSho0YvKSHIR9KBr
WVSIBdWiIoho46ZZBEGUIUpPVJKr1sVn5s4W4Z25szkc5pzfzHzf1AyMdw2L
giA0CIJQPCmymFFuSs9NebCokcah7bKzYGUevI/FSOIcLIohyy+0qpHAwYVG
Y8yUg/29Yij4KdZdRh6yQLxvvOt5rl/9SDEvjjPZUr97VgEV9xjFQkmqakGK
Mk/GFbAGc/Nh5kVQeh37KhgDzPvEqWqz3FGL/D+IRzG9cnV9gbvq+3ecOHnZ
XH/zItV7weUOW4Vz7R1bVH4AtybNBsdxBInnw7ijSe5PxPj/PR6IflG3qGCz
+v4W7YZOqbszyXkPWpfcUrQ3jZJ6P0VdeybUt5NBTUGRdTykPJRznu4emOb/
euKDjfmUvwcX1+f+QOuvjfqHDe5/hOaDJZ7PRfNDF8/vI30gHCV9WD/Q9GN9
QdOX+DI4Wf8n8gf+2B+qFwc7+8f+guYv+w+a/8RLgLYfxEvCPO8P8dIwyvvF
+wc/vH//JplLXA==
          "]]},
        Annotation[#, "Charting`Private`Tag#189"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1klsow3EUx/944Ul48LIUpdzK/VLKyYt4UNI8IJGyFOVliQcPc0mxhRQm
RdSWywPJasR5WGI1WpvYMM19s9mW8KLQ/uf8zsuvX+f3+5xzvt+T3tnX2BUr
SVK2JEnRkyKCGR5Fe9nkN6jkCGFlrnr1uv4bzmzRCGLGWoqybv4LiuUIoGG3
Zvm35xMW9dHw42ypW6d0fgDxfGjLGtYoryLMe0HTX2AkHP8OMs72hHdDzbjj
eGXeI7aoew+38x6Yd49tFQk592oX87y4eTI6YBg75f+3OKMvnBuca4AF+b0b
L/tP4+INJ0j1LtGk1UYsqVdYJPOd6NLp3TEmLxLPjjfGjllF9TPSfytaffl7
T4l+LJDfW7B8XVX7kxTkvBmTq1o9mqoQTsv3dRx37LtgKoxCwVjWcYXyMMF5
uptB/K8gPgg+5a1wzPW5PxD9lVD/cMH9d9N8cMDzLdH8sMXz20kfKNogfVg/
EPqxviD0Jf4jNLH+5+QPvLE/VO8Fjtg/9heEv+w/CP+JFwAj7wfxgpDG+0O8
EIj94v2DTN6/fyHQSKU=
          "]]},
        Annotation[#, "Charting`Private`Tag#190"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kj1IgmEQx19sCFxqaQgi0IZqiESLHIKLVnMJCwpKCLSaooZaGoqgoIY+
DPpALCqHBmmoIC05woYELa0w+iLjVTFeMYs+pCHC9+695eHhnud3d///afqG
2m0qQRBqBUEonBQ5jD2N3bqv82CXI4sGR+WRZykP4VAhMlgnVGh7oz9gkEPC
pP29Y2z5G9bXCvGKZdrx4oD4CcRL48h8TicGP5iXQnRuq0ssOZBxoQTO6cXS
iSqJeSJ6LLmvrZok815QP2t1dPuemBdH20T/5WE0wv8f8bzN79Wa9mBVfn+H
FvXwSXPnKVK9GN7EjT7Tyg3qZf41PqTuW8unn5F4EbRmW8z7jgTS/yAe20br
t11p1MnvA5jvavIPRiXOe3GyvqdoUZPFBfm+i64/d+x35g0VBVWs4yblYYfz
dPfCFP83Eh++mE/5IPi4PvcHSn8N1D+Euf8Bmg8iPJ+T5gcNzx8hfaDRTPqw
fqDox/qCoi/xRThg/S/IH9hgf6heCs7YP/YXFH/Zf1D8J54EEu8H8TJQzftD
vCwo+8X7B1e8f/9VeUl/
          "]]},
        Annotation[#, "Charting`Private`Tag#191"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx19LCrvyMVeS1tRwsczFXJ1ys+RClHbBlXwVJSkpLXtdKCJT
LtDKmPJ1ZbXWaJ0LXGC05isybV7m1TTSktiF9p7znpunp/M8v3PO/38qu4ba
ejSCIBgFQcieFJ84/Ti7VWH4g14lUtjgKxPtsV84D2XjHYM744XWkl8wK5HE
VYduQzz+gZXlbLxh62SVrT/zDcSTsTH8k2M5SjMvgcWZK49c/QUKLvSMZ7rB
4K6YYp6EXmffvdckMy+OU+ZIvn8mzrwYZvTpbvvINf9/QK0gzvc0ISwp7++w
86ndZb31IdW7QTlhcBu1EaxT+JfYsbCG+qUoEi+MTk+wYECSkP6f4GvRXstY
jYwm5f0hnm/mNe3PJzkfwIlY82l5bgqdyn0bx4ZrTxcdH6gqqGEd3ZSHUc7T
PQB2/m8hPoSYT/kTkLg+9wdqf/XUP9i4/36aD154PhfNDxqeP0z6QCnrw/qB
qh/rC6q+xJfAz/pfkD8QZX+oXgLK2D/2F1R/2X9Q/SdeEtZ5P4j3Dge8P8RL
gbpfvH8wx/v3D4MZRFU=
          "]]},
        Annotation[#, "Charting`Private`Tag#192"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kklIQmEQx19dlCCIjmEHowSpg6RUpyaKCopIqkMHQRKSCFuOLVRChxYI
QiuyOrSc9OAlCIVgoggJVIQgaDkUymt55UILGRnhm3lz+fiY7/vNzP8/WttY
z2ChIAh6QRDyJ0UaO6xvnvPZHNjlSOKy0VY1UpeDSDgfrxjwNZmrrb9glENC
zARmOv9+YMuTj2d8aSt1T2uyQLwnNHfZLOvnX8wTcXxY0vWpP0DGhROY9b77
vz/TzItjuWti7bhFYt4DdntUkaLmBPPucd65UWHX3fD/O2zc/tSJ7hBsyu+v
cVFfllEf7CHVu0Jn4c/cSTKKtTL/EotHK7Pi/i0SL4apydTtkiGO9P8CI97Q
juvoEQ3y+zPULjj8qi6J80EcaA/UmMQ3XJXvXuytLz0smUyhomAB67hLeejh
PN2DYOH/DcQHDfMpfwEhrs/9gdKfifoHNfc/RPOBg+fbofmhkeePkT7Qz/qw
fqDox/qCoi/x46Bh/aPkDwg+8ofqiTDF/rG/oPjL/oPiP/EkOOX9IN4rKPtD
vCSs8H7x/kEr798/h5RDvw==
          "]]},
        Annotation[#, "Charting`Private`Tag#193"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk1LQlEQhm/tWgS1KejbVUkUkhEJyQjRLgpKCleJUbiRcB20yB9gYklZ
F8pNuIlCIoRisIIQNIU+wIoyDVOuWURCIFp4Z+5sDoc555mZ9x2VZWlqoVYQ
BLUgCNWT4gtLzknT8csfLMpRwHjf48m2+w+ikWrksWPEpO4/qoBWDgmzd6FM
RV8G71Y1ctjl+BA0oyUgXhaL6Z+KLvrLvAxa3fMBUSqCjIu8YcOledVx+M28
NF7n5sY85gLzXtHUE2zqqn1nXhLf2sYPfNln/v+EZ6N+7YQYg035fQJT25aa
0xUX17tHr0405gNhHJD5N7i5ofep9xNIvDiaW7ujM8sppP9hfGg0DKkM76iR
31/g7N55va1O4nwQO33a6eTVB67Jdz+6oFe02z9RUbCGddylPDg5T/cgtPP/
YeKDkfmUD8Mt1+f+QOlvkPoHD/dvpflgnefbofmhQaT546QPlFkf1g8U/Vhf
UPQlfhpCrP81+QPN7A/Vy4CN/WN/QfGX/QfFf+JJIPF+EC8PLbw/xCtAjPeL
9w8qvH//ialENA==
          "]]},
        Annotation[#, "Charting`Private`Tag#194"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kkEow3EUx39T5IA7QuNCJM0OlLylHCgOKK7U/lFYuUoULbWGdhobc9mB
m8Qah1dG7a9Z+IsmYaaxmaEpRaL93/u/y69f7/f7vPe+36cfsvSYc4QQNUKI
7EnxjmcZ2+hclc4kqZHGhda6TsePMJ2EspHCmYp9h29OmBrVeMGW6UTXwewf
rCxnI4Hn0drxHcsvEO8ZZz+wb/D6G4gXxztZMRVdfIGKCz1iics9FrZ8AvFi
2Hxk7s4PvDMvioUOgzUhJ5h3jwvH1Wv1N1H+f4M6qX3g8VYBp/o+ghLqg2W+
La53iZlVVyQ5cogGla/gviTEjvcKiXeKHfa2UPFhFOm/jJt2Z6A3GMcG9X0A
CyYmr3OPkpz3o9XTv1i/8YpL6n0DH4zlnr2RN9QU1LGO65SHOOfp7od5/t9E
fMhjPuVl8HJ97g+0/ozUP2xz/8M0HyR5PjfND7s8/ynpA6WsD+sHmn6sL2j6
Ej8GRtY/TP5AJftD9eLwxP6xv6D5y/6D5j/xXqCJ94N4KZji/SFeGmy8X7x/
oPD+/QMx30Xa
          "]]},
        Annotation[#, "Charting`Private`Tag#195"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kj1IgmEQx18Fl96hoaVo6YMIi0rSQejjpHCIiCAqMFwqFIcoF4sojIgg
oiBosQgsnIKGoCFcvMoWQU3oi8BBU9TSLKJMISh8795bHh7ueX539/9f/dTc
iEUpCIJaEITySfGBBceGKWtSGqxS5LHbU4xVapSGULAcObx4VRnXzxQGrRRZ
1DXcOcxpwbC/V44X7Jvp2tIf/QHxMij6xXB/7heIl8Iaoecre1ECCRdMojPT
/NyuLQDxEnhajHqXTJ9AvDjuGhdsY64c82IoztuHogNJ/h/F6nTLdVXpEVzS
+yc0+7+dqx3I9R5wsNa8eNLkw06Jf4uWWbVr1H2PxIvg+bJ1u1aMI/0P4E1F
3/TEcAo10ns/enoskbeVV857Uby6HG/dfMMd6X6MisbGp/zkO8oKKljHQ8qD
kvN094KK/+uJD27mUz4AIa7P/YHcn476BxP3b6P5oI3nO6D5wc7zR0gf0LI+
rB/I+rG+IOtL/ATI+ofJH1hjf6heCurYP/YXZH/Zf5D9J14W9LwfxMuBj/eH
eHno5f3i/YMf3r9/bWE3yA==
          "]]},
        Annotation[#, "Charting`Private`Tag#196"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kt8rg2EUx99tV67EJhdCblYrF5pdiHLepSgXkgvJhdpqGlkLF8ofwIUV
hvKOpCRxofy4WS3Hj9paIVojszLtR9hs4mIY0d5z3nPz9HSe53PO+X5PndXZ
Y1MLgmAQBKF4UryhdsjYIbk14qAcWbT/mOuvBzXixXkxMjgfOL53JdRioxxp
1EVq3KpSteiRivGMjnhoazQtiMR7wkzZb0ul+g+Il8Id/eHE5F4BZNx5Agc8
+6rPrzwQL44zJ35TyccHEO8Rz6y9nV0jOSBeDN/78qt2X4r/R1G6rW6XqqKw
LL+/Q61heurU4ud6N3ggmfdWLAdolPkhXLKVP4QXQ0i8KxxbMzk3u2NI/4Oo
t7RJtnASG+T3Z6jPR57E5hfOe/E7qWmND7/inHzfRr/jaLysP4eKgirWcZ3y
EOA83b1Q4P9NxIda5lM+CNVcn/sDpT8T9Q+z3L+d5oMNnm+V5ocunv+K9IFd
1of1A0U/1hcUfYkfBxfrf0n+gJX9oXop8LF/7C8o/rL/oPhPvDRU8H4QLwML
vD/Ey4KyX7x/oOP9+wfuXz5+
          "]]},
        Annotation[#, "Charting`Private`Tag#197"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1klsow3EUx/+2yYsXl+yBl60oe8FckqzzlxeXXKI9WGm1IrxQKHnwIPGg
uZRySS6FTCnytKSjprTahG1KKVszmc3ckzS0/zn/8/Lr1/n9Puec7/doLL0t
HQpBEPIFQUicFC+4Z0s+yXKrxE4pYugJGAfMqyrR7UpEFPd3AqdtapVYLEUE
qzL/Bs3lSnFpMRFhbDTtbsdSFCLxHjDHmjo/YRWYd4/xx7nWn404SDjXHYaL
ht6GHd9AvCBq/F/H6dOfQLwA4qHvpF37CsTz44UimnWrD/P/G6w+zKjt0fph
QXp/jX1j9vlgmRuo3hWOjPbX+NTrqJf4HiyoqwylTFwg8c5Rvak7Uuhukf47
0eidMmyZQlgovXdgRXeoKfsjzHk7Kr2T75b6J5yR7jYcXxlayW15RlnBJNZx
jfIg5+luh18P/S8nPpQyn/JOaOD63B/I/ZVQ/5DH/XfRfNDD8y3T/DDL85+T
PtDM+rB+IOvH+oKsL/GDoGX9z8gfeGd/qN49pEXIP/YXZH/Zf5D9J14EDLwf
xIuCvD/Ei8El7xfvHxzw/v0DY7Y5cQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#198"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8ow2EYx3/+bTg4kCVJOTjIWmJlND0/Tv6TEz+5WJNc5qDlgAMHOWAl
hTlMScTkxkiPIlmNFlGK/Nla1mY0B0TRfs/zPpe3t+d9P8/zfL9PUa+tw5os
SVKJJEmJk+IdLdOjrZF0jdynRgwHbfvxuts0+dyXiCgq+lqbvSlNrlAjgmta
py7VkiovLSYijMr3at5acYpMvBccVsbWDc4k5oWw9Xm+fnvpD1ScL4grR1lG
7ewPEC+AvYaapy/9JxDvCfvNU3HZEQfiPaLWBLqGrQj/v8Pg5MGvo+oZFtT3
txiaOTNXZl4C1bvBjs5s18neOJSr/Cv8yNdk2F8vkHh+NF+3D33s3CP992LB
SM5Ay0MQy9T3x1hU3ta16A5z3oOHpxPVu6Wv6FDvG9g8PTdjaHxDoWAS6+ii
PIg83T1wwP9NxIdC5lPeC7lcn/sD0Z+R+ocH7r+f5oMsheZbpvlBM0vz+0kf
iLI+rB8I/VhfEPoSPwDdrP8F+QNu9ofqhUBh/9hfEP6y/yD8J14ENnk/iBeF
Ht4f4sVA7BfvH1h5//4BbcEtDw==
          "]]},
        Annotation[#, "Charting`Private`Tag#199"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxVkl0og2EUx59mTLgSKSm5kHaDfDUXOu+WiZILIrWrTST5uHLlI24oablQ
hil3Pmq72J0LnfJRxmuRNqkRec1mMysuUKK957wXzs3T03me3znn/z9ljrHO
fp0QwiiESJ8UKRztPVrYsBqkATWSeBtyGzIKDNK5nI4ENra02odnsqRaNeKY
1z6/MunMlNZW0xHDy0rxY2zWS8SLYn53OOLa0TEvgqHCkmD0REgqTlbweLr6
48X2A8R7xMCB77lY/gTiPaCnS9Zbft+BePfY5uyxeCuSQP/D+C0VrY90KuBS
399geZM9OzgRBKoXwhyrw10/tws1Kv8KM7dLi2f9p0i8C6zquBvyNYSR/vux
0LE8uNinYLX6/hBbbN7x64EY5/fw0+95SuS+4pJ638Hn4f2pKssbin+Rwk3K
g8J5uu/BF/83ER/MzKe8H/K4PvcHWn911D88bVH/gzQf6Hg+N80PEs9/QfqA
wUz6sH6g6cf6gqYv8R9BZv0D5A+csT9ULwJ37B/7C5q/7D9o/hMvDtp+EC8B
Jt4f4iVB2y/WDbT9+wNf0DH3
          "]]},
        Annotation[#, "Charting`Private`Tag#200"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxVkk8og3EYx1+TWdsFF05E/iQUmyQOz1tyVkrJn2LLmsgODhykxUkOHGaZ
dlitRC5qqeHw1Iwao83f+XOgMeQ1byJxob3P8x48l1+/nt/v8zzP9/sUm+3t
AxpBECoFQUifFDKuFG6N+6d0olWJFC7XLdjL23TiYSQdErrWpNnQRrZoUuIF
B2smJju2tOKSOx3PuF/aGjRYskTiPWFu9/ppbyCTeUn0uZw9sVCGqOAi9xjq
K7OMVv4C8RJo1nS1XAz9APHu8MmdNxcb+QTi3aI2+DWtb5eB/t+gv1MuqB5O
wqLy/hId+hLbayoOVO8cT0xd87umABgV/gnm28T7U98eEi+KHw2OsbPtK6T/
YcwwtXmdjwmsVd7v4MOMteK96Jnzm+iJNx/nSBLOK/dV7BeDK1VNbyj8Cxm9
lAcz5+m+Cer/RuJDgvmUD8O3kepzf6D2V0/9g4H7t9F8cM3zeWh+cPL8UdIH
AqwP6weqfqwvqPoSPwFW1v+I/IED9ofqJWGV/WN/QfWX/QfVf+K9gLofxJNg
gfeHeCnw8X6xbqDu3x8GIjeS
          "]]},
        Annotation[#, "Charting`Private`Tag#201"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxVkt8rg2EUx5+WH5NyZTdKGiFX2FwIdd79Ay7cuqCVRStcSH6lJCkuzFwY
UWM15oLiQrs6fqzWataiZHoTpnnZzLjYCkl7z3kvnJunp/M8n3PO93uM1qGu
Pp0QokEIkT8pMuiWK/cOsUSyqZHGGtfCuHmhRLoI5yOFtfbgcHFSL5nVSKKi
VDxXJIql9bV8vODAZPOgPFMkEU/Br0CrszxYwLwEvrdt/+6f6CQVF37C56PA
7OikYF4cIwcn4cXSHyDeA+7Y2709d1kg3j1O6HfnLY4PoP8yVt364rk5BVzq
+xguG8o+jVYZqN416o57bb3OUzCp/Cv0jI28GabPkHhRDNQ3eD+lGNL/EH53
T82u2uPYpL4/x5usN1cYUzjvR/2m97ExnEKHevfhiqWjs870juJfZNBNeVji
PN39UMD/W4kPl8ynfAiyXJ/7A62/FuofVrj/fpoPBM+3QfODh+ePkj7Qwvqw
fqDpx/qCpi/x4xBl/SPkD6TZH6qXgFf2j/0FzV/2HzT/iZeEF94P4qWgmveH
eGnQ9ot1gy3evz81Vz29
          "]]},
        Annotation[#, "Charting`Private`Tag#202"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxVkksoRGEUx69Xxs1mYmOi8cjCowjFQp1bsvFaSEg2lPdCysJjNgql2chC
M8JMUqJRopSisyCajDEYb3kbg8kMEQpp7jl34Wy+vs73/c45//+Jq20trQsU
BCFJEAT/SeFDe6KlI/ZblOrleMapKH3u3Joobdn84UETaKpWtKKUKccT5k8a
FivVYdKI0R8P2Gce2Ek1h0rEc2NEyXV42X4I81z4kt29rV0OkmSc7RZdGSbV
bk0A825w825EPTzzA8S7QnvifkJ18ScQ7xKLzt4Of7degf6foVMMlr7HH8Eg
vz/G94/dlEjnBVC9A2wTekpOVBuQIfP3sFNjbNpZWEbiOTC6S/djWj9E+m/F
9op53br3GtPl96uo729oSRtyc34JTxd7v8otHhyU79N4j3mz8cleFP6FD82U
ByVP9yU44v85xIc+5lPeCs1cn/sDpb8s6h8Kuf9Gmg8GeL5Rmh9iPml+B+kD
56wP6weKfqwvKPoS/wa2WX87+QNe9ofquUDxj/0FxV/2HxT/ifcEBbwfxPPA
GO8P8Z5hgveLdQMb798fE6k67Q==
          "]]},
        Annotation[#, "Charting`Private`Tag#203"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxVkl0og2EUx9+WtIYrN66UYaWEfIxC502KSMlyLZqPUmTIhZSQWIxczVpt
FOXGha1l+TgkF7TZarWSFds0kzUudmE3m/ae8144N09P53l+55z//5SNTA+M
KgRBqBIEIXdS/OD5S1HbSnOhOCZFEsV+g1edKRC9nlwkcKHctjOlKxAbpPhC
u7baZ2lViZb9XHxiptbu3r5SisSL47JzssYRyWdeDNfWP15vXXmihPO849Dp
2aChS8G8KN4Uttt03VkgXhi97sq49iINxHvDo9Rj3b0qBfQ/hMq+9LHelQCz
9P4Z1zFV5DgIA9UL4rXDvFS56IF6iR9AK6pLIjNOJJ4fO3o0nbN9QaT/D7jj
bwoNzEWwTnp/h4HliV9jb5zzbtwc16f2thK4K91PUJMtzatQf6PwL37QTnmo
4Dzd3bDB/1uID17mU/4BVrk+9wdyf43UP5i4/wmaD3w8n5XmBxPP7yd9oJj1
Yf1A1o/1BVlf4kfBxfo/kT8wzP5QvRgY2T/2F2R/2X+Q/SfeFxzyfhAvAfO8
P8RLAvB+sW5wyfv3B3WzN6A=
          "]]},
        Annotation[#, "Charting`Private`Tag#204"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxVkl0og2EUxx+WJBaLWu0Ci4WkZEJcnLfEnRspuZi0EGX5LCKRWtGk3Sgf
S6LEhSIX2o2j5GMZrWi10tqa1mTNIvLRor3nvBfOzdPTeZ7fOef/P3rzYGtP
qhCiTAiRPCnieFI6PmMaVku9csSwOxfGNDVq6cadjCi22FS2bWuWZJTjGWsP
9Y2W7kxpbTUZTxjYmNTbfRkS8SIoNtYzXbF05oVRBdn9xoM0Sca5H3F2f2sn
Ua5iXgi1Re8GzYhgXhALahK6rpIfIF4AF3KulrXN70D/H9A6FSg0XcdgRX7v
Q51/aMDUHgKq58UPv7Fz8c0DVTL/Drd+jy6bRneReB4sbmq4SPHeI/134XS+
dG75CmKl/P4MXfN139VpEc47scO6txMfiKJdvu/hseN1qUL3guJfxHGT8uDk
PN2d0Mb/64gPZ8ynvAsmuD73B0p/1dQ/mLn/PpoPPnk+B80PBp7fQ/qAg/Vh
/UDRj/UFRV/ihyCP9b8lf2CO/aF6Ychg/9hfUPxl/0Hxn3jPUM/7QbwoKPtD
vBiYeb9YNzjl/fsDmWwqWg==
          "]]},
        Annotation[#, "Charting`Private`Tag#205"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxVkl0og2EUx19raWmjJjfbFXKB1PLVpJyXRigpbmguWCyyfCTFtuLGV7vZ
uPCRCzc+diM3LkgdJaFGq0mJi8kMbc20WGpKe895L5ybp6fzPL9zzv9/8i2j
HQMKQRCKBUFInxRxrFx9qDZ6s0WrFDEMD/8GFbZs8dqXjiiqWr9KXw41YoUU
EcwzOBZ6XGpxYz0d79iUclrOE1ki8d6wfn9SW/ajYl4YPzWY1O5lihLOF8LR
2sw5XY6Sec94apiCg7oM5j2h3dQ13OxJAfGCGLrYWZye+Qb6/4ixXkf70kgc
1qT399gdsrvMWS9A9e4wd8h30rQdgHKJH8BljcbaWeNG4vnRPHusC/YGkP5f
oW2sUd8884QG6f0ZlnhMuy34yvkjLFwZv3W2RdEt3b3Yr5iYb9B+oPAv4rhF
eejjPN2PoID/G4kPRcyn/BUMcH3uD+T+Kql/uFRT/4M0H+h5vk2aH6w8v5/0
gQTrw/qBrB/rC7K+xH+GE9b/hvwB2R+qF4Yk+8f+guwv+w+y/8SLgI73g3hR
UPL+EC8GEd4v1g2qeP/+AA2kKUA=
          "]]},
        Annotation[#, "Charting`Private`Tag#206"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJxVkl0og2EUx1+ar/kqF9wpd1zQMuGG82qKKWnuFIWQcrEitNJcuBtqroxo
24WPibjQZD5OUmo1i9RCkjXG2ppJMy58tPec98K5eXo6z/M75/z/p6RX396f
KghCmSAIyZMihusn1nfLfb44IEUUq2fLu43WfPHck4wI7h1uhA8DeaJaijC6
MpWr8e1ccXEhGSG8VZj6MDtHJN4LeuP3NeMpSuYF0bRZOP+7nCFKOM8j+n+2
XvUxBfMC2DR2duDMSmWeH9Fw3drz+Q3Ee8Cp6Eq93pkA+n+Hw0e7jo7RN7BI
72+w6DZxI7iCQPV8OKdt0O3ofFAp8a/Q1en2qNRm5l3gRKAlZI9eIv13Y5tP
oy9I96NKen+KGls87cnwzPl9NFxPljdWRNAs3R34NTRfPKB8ReFfxNBGefjg
PN33YYT/1xIf6phPeTc0c33uD+T+qqh/mO6i/gdpPrDzfEs0P5Ty/BekDxhZ
H9YPZP1YX5D1JX4AtKy/l/yBF/aH6gVhhv1jf0H2l/0H2X/iheGY94N4EXDy
/hAvCvJ+sW6wxvv3B2TYP2Q=
          "]]},
        Annotation[#, "Charting`Private`Tag#207"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx99WTAmjlhvLR6MWRT7yUTrvJUlCLnzckGlKXMiFC5OkURRX
Pi8kigtFinahc6FkNbOxZHGxNfnabBK2kGnPOe+5eXo6z/M75/z/J7dnqMWo
kiTJIElS/KR4Q9dH++zktEbuExHCgoN6daJJI5/b4xHEouZnS4daI5eJCOBv
dmjw1JUqryzH4xnlNsu5JjdFJt4TVlVu6mV1MvMesLp28XtpIUkWOPs9Oi7r
J7YuEpjnx96fBpv7UsU8H84UZtboumJAPC+atZ/usZco0P87NKdEJ49G32FJ
vPdg58B+zobxCajeNVZs6Y6tkRsoFfwrvPry32oN28xz4khq455n3In034aO
fP3r75wXS8T7Ezys8/ryKh45b8XB1rK61rQgzov7DmYkNE2tqsKoKBgTEcZ1
ykM65+luhX7+X0V82GU+5W1wxvW5P1D6K6f+IStC/ZtoPijl+dZofhjm+Z2k
D1hYH9YPFP1YX1D0Jb4full/B/kDLvaH6j1ALfvH/oLiL/sPiv/EC8Af7wfx
glDM+0O8ECj7xfsHF7x//5oHNGs=
          "]]},
        Annotation[#, "Charting`Private`Tag#208"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx98minzMDRcku/SR5qspF+d1hQslRJFiIhEKyUdSEqMVNz42
K5KSmhJSby5OS6yFJUoJZY2Faaat1NLofc95z83T03me3znn/z8640Bdp0YQ
hBxBEOSTIohDw5q52OxUsUuJAP5Cwaw1qhWvLuX4xJKkvv78da1YrIQfG/S9
u63BFNFqkeMdwx0GfU1xski8N3Rm3rXrEhKZ50OT3bQzNR0vKrjLF3RPdq90
2OOY58Vx82jliSWGeR588vSEfloF5j1j1WD+TF5GBOj/Izqap6TyiRCsKe/v
0dG7er6c+AFU7w4PW9oMjSsPUKTwb7HJWHsmxR4B8a5xr+IorTDXjfTfheGF
0mpD+jPqlfenuOqKd2R9+zgv4XazyXYc9OOSct/Fg60yz2skgKqC0T85vnCT
8rDPebpLsMH/y4gPi8ynvAv8XJ/7A7W/Euof5rn/bpoPkOez0fxwwfNfkz7g
ZH1YP1D1Y31B1Zf4Xhhj/d3kD9ywP1TPB2b2j/0F1V/2H1T/ieeHet4P4n2C
gfeHeAGI8n7x/sEI798/VeUzoA==
          "]]},
        Annotation[#, "Charting`Private`Tag#209"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx19SQmKFRLtwJV8RSz4uzrPJR65ErobytVYUucPFpNmdj3Kx
DUVKcsHdLjbqFEljNISE2ZoWbY0aRfLR3nPec/P0dJ7nd875/09B30j7YKIk
SUWSJMVPijfEJnut1aESBjmi6HUd3mgXVeLUE48IDhj3+vPKVKJKjjBaVhPX
N2YyxZI9Hi/YXNNVl6LLEMR7xqvZUbMjJZ15IfyKbas7R1OFjPM8oW7YM9Zh
SWZeEH0dnc/5PUnMC6Bfa9FtpiUwz496/eXFX/M30P97rFh3N06Nv4NNfn+L
vfXqLM1OGKjeNZp2Pj8mS31QKfMvcUKUl2gedoF4Xsyxzr3fdZ8g/XfjwLFN
H2h4xAr5/QEenTfdxrZDnHdi7n6haeIijAvyfQuLlrvbWmJRVBT8/YvHK65R
Hoo5T3cnZPP/GuKDi/mUd0Mr1+f+QOlPQ/3DPPdvpPlgmudboflhiOf3kj5Q
zfqwfqDox/qCoi/xgxBg/c/IHxDsD9ULwQ/7x/6C4i/7D4r/xAuDmfeDeBEw
8P4QLwqnvF+8f6Ds3z+KZzbb
          "]]},
        Annotation[#, "Charting`Private`Tag#210"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8og3EYx1/LolbadlsUDjbiIKZceF5/CjloO8mfi6JF8mfmsIOLnFyk
1Pw5uEkOLprG5mlElo0VTSRN00zvbCspsUZ7n+d9Lr9+Pb/f53me7/epHJmy
jqoEQagRBCF/UmRwNuyrznXrxTE5UujwBx/9VXoxFMxHEn9bj6ySVyc2yiGh
qUNq0+p04sZ6Pt4xO6iZmTRqReIlsCjX3u9SlzAvjvNO8e94QCPKuOArfnZq
x8qHi5kXQ8zMW3bL1cx7QVWXlL13FzAvil7318XidBbo/xMamkKTFXNf4JLf
P6C9dMdx3/MBVC+Cd+OFvatDUWiQ+bf4VoeJ9JUfiBfGte5ly83mJdL/AI6e
Gqz7Q89YL78/Q/Pbodo3Eee8B32WpbK9AwlX5PsuTrRk4udSChUFc3/5SOM2
5cHGebp74IT/NxMfaplP+QD0cX3uD5T+zNQ/ZLl/G80HEZ5vi+aHBZ4/TPqA
ifVh/UDRj/UFRV/ix8DL+l+TP/DD/lC9ODjZP/YXFH/Zf1D8J54ERt4P4iXh
m/eHeCmw837x/sEc798/1bY8oQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#211"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kt8rg2EUx99WLkjGLmZuiFIsZTE1P+q8XEgkhaSsRO1HSky7kT+AcuOC
MJSryc8rKzKdpKkVmlYrbMsaa9p6hyI3G+095z03T0/neT7nnO/3VE/ODFpU
giDUC4KQPyk+cM9sdwtPGtEqh4QRb1VbzKMR727zkcav0I1k7dWIzXKkcDa5
VGFylYmuzXy8o2eh3X+0XyoSL4mHn+oiW7aEeQk8eNebRjuLRRl3+4r932uZ
OUMh8+KofejpKI8WMC+GF7mt5e5xFfNesM54o+1azQL9D2PtlyN5NvUDG/L7
R+w7/fWGoxJQvRBeDliu3DsxaJL5QdQ+Oz5HNn1AvADqFqema958SP/9GK8M
thjnI2iQ319jg9PmXdUnOH+OraNq5/B6Clfk+z6abSUnE68SKgrm/vKRwV3K
wxjn6X4OjfzfRHyoZT7l/RDi+twfKP0ZqX9o5P7tNB/4eL5tmh8sPH+A9AE9
68P6gaIf6wuKvsSPg471vyd/YIj9oXoJOGb/2F9Q/GX/QfGfeClQ9oN4afjg
/SGeBFHeL94/cPP+/QNDxTty
          "]]},
        Annotation[#, "Charting`Private`Tag#212"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx98QudhkboQWccGWyFdyc96yRCKmlQu5UGOkltRaU5J2gRsr
lMmFjytFLTc+kiMu2HyWCE2ZMe9Mszslbdp7zntunp7O8/zOOf//KeqzGs0p
giCUCYKQPCliuH6WCJstOWK/HFG0Z2w6BxpzxMuLZHxhc6nh3HSnEavliKC1
1zjwUagRl9zJCGNFmVs/q8sWiSehS/vUcRTLYl4If3Gs5LpYJcq4izc8tO0H
fhOZzAtirrS1kOdOZ14Ap0f9g560VOa9oEFo6T7djgP992Nwvi1d6vmBRfn9
IxbpfZ7OuhhQvXv0HNvL/x5eoUrm36JxeCi/3eQF4t1g65wzRWo4QfrvxVr1
QZPP7cdK+f0Jqh2qtIXPd87voUs70jXpiKBLvm/gxO7UmvY5ioqC8UQyvnGF
8jDOebrvwQz/ryc+ZDCf8l4o5PrcHyj91VD/YOb+LTQf7PB8yzQ/6Hj+G9IH
JNaH9QNFP9YXFH2JH4QC1v+K/IEz9ofqhSDO/rG/oPjL/oPiP/EiMML7Qbwv
UPaHeFGw8X7x/sEq798/YIw0eg==
          "]]},
        Annotation[#, "Charting`Private`Tag#213"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1klsow3EUx/94WDwIy+MeKIlSM3vw5PyU5pZreZDsQQ17oZbkwYvyJA9e
FEtuSUN5cSmKs7YHsVkLM5eVy2ZZY5Zb1DLtf87/vPz6dX6/zznn+z0FPYPt
pnRJkkokSUqdFHEcmPgs/v5Qi145Ypj1Gq7ReNTi1J2KF8wZXbKMdatFhRxR
3PYNd0ZW8oR1NhURbC7cz3i05QriPaPxtLRxeTCHeWGsP1DtHqVlCxnnDmFV
Sd24yZXFvCDay9/nzK0q5j3gsL5PXKxmMO8eLXZJu+xKAv0PoCZgvWpq+IEZ
+f01Tg4l7gy/caB6l1i7oFvPzw6BTuafo+GsQ3T9uYF4Xtz5cl6XzduR/h+j
/+mm4OTwFrXyeyeOBRNm/8YT5/fQloi0CWMUp+T7GjoCm1tJXwwVBf+SqXjD
RcqDk/N034NF/l9JfBhhPuWPwcH1uT9Q+tNT/2Dh/vtpPmjk+eZofpjm+b2k
DxSxPqwfKPqxvqDoS/wgOFl/D/kD1ewP1QtDC/vH/oLiL/sPiv/Ei8Iu7wfx
XkDZH+LFIJP3i/cPzLx//5bGRFo=
          "]]},
        Annotation[#, "Charting`Private`Tag#214"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx5+G5mNtmOxSQ0q58LELSs6bciE3UnJJ1pgbCheSciUfuZAr
k8SdpSiEaXViJctsK5Gt5Ws2H9PMhZkbtPec99w8PZ3n+Z1z/v9j7B3qsKiE
EJVCiPRJkUBNR3BjfKJI6pMjjpaAy+DpLJIuPOl4R0/yeWLvUS/VyRFDu91Z
lluhl5Zt6XhF3ezdwUh5oUS8F5zBBl3bUz7zorhVYLK9BbWSjPM8YbfJuN+7
mMe8MCZu1CpnRjbzHrBnJ1MMt2Qy7x4ntW1YMyT4fwgf9Oau+dofWJLfB7DU
cbUpDj+B6l1jMmTwjTVGoFbmX6Jmu/12qtUPxPNj/lnxcarEifTfjcsDgdW5
lyBWy+9dqO1vSo0ORjjvwO/To3NbcwwX5Lsd163GE7UvjoqCv3/p+MA1ysMq
5+nugC/+X098yGI+5d0wzfW5P1D6M1H/UMD9W2k+SPF8KzQ/VPH8ftIH3lgf
1g8U/VhfUPQlfhiSrL+X/AEz+0P1orDL/rG/oPjL/oPiP/FisMn7Qbx38PL+
EC8OZt4v3j/I4f37B8ISNK0=
          "]]},
        Annotation[#, "Charting`Private`Tag#215"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kt8rg2EUx18/YknEtlZyg7JE0ssFJee9kOFGSbiU+XWhlH/AJHLpSmjW
ynaxhgs3WK1Du0BGi1Jb2Pxa9K5NyoUxtPec59w8PZ3n+Zxzvt9TNTrTP54r
SVKdJEnZk+Id41tfUX+OUZnQIokn5ppAR8SgXASzkcAu37HbN2ZQmrVQsbvw
3mBy6ZWN9Wy84aJ3yq/fLFeI94qN5r/VhsEy5sWxMx0dftwtVTRc8BnlTEWJ
a6CYeU842VOUd76nY94DRuy2795YPvNi6Jg+6Or7lPj/LVa6Q0sWYxrWtPdh
zNT/LDTPfgDVu8HgUXtsxxoHWeNf45zbY0vrroB4IVQj1vnt6n2k/2eYkmF3
xBTBJu19AK3R2/ol+YXzh+i2eO/WzSquaHcPPvg9jrbTJAoFf/+ykUIn5UHk
6X4ITv7fSnwYYj7lzyDM9bk/EP21UP+wzP1P0Xwg5rPT/FDQQPOHSB+oZX1Y
PxD6sb4g9CX+Ewj9L8kfaGd/qF4cutk/9heEv+w/CP+Jp4LYD+IlwML7Q7wk
iP3i/QOxf/+H6zvx
          "]]},
        Annotation[#, "Charting`Private`Tag#216"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx19ETa18bLUQWUkuyGdWsvO64eJ1wyWNJZYLcrkLpdaUxIWP
1HxlJatlKK5W6viIUiOlFAkz5uPVyEdEM+095z03T0/neX7nnP//5Hf0NXcl
CoJQJAhC/KR4xZKbZseIUy/alIhgbfaGVNeqFw8D8XjGKstn0BrSiRVKyDg6
ZFm+zNWJM9PxeMTJwI5vIiNTJN4D9vtyDVl76cwLo8O9vrViThMVXOAWPZ1J
vxfpWuaFsD0mDDdZNMwLovXqSzDak5l3jYM1OfMf9gT+f4Eel3u24O0HXMr7
M1xM8S1NFb4D1TvFv6fqKDjvoVzhn2DjRMv4+eYJEO8Y74oHPvvq15H+H2De
vtW0IJ1hqfJ+F6tebbLx+5bzfoz1eK2SVsYx5e5FqdegcW1HUFUwGovHC7op
Dw2cp7sf/vi/ifhQzHzKH0Aq1+f+QO2vkvqHNu6/m+aDGM83R/PDGs9/TPqA
qg/rB6p+rC+o+hI/BF2s/xH5A6vsD9ULwyD7x/6C6i/7D6r/xJNhjPeDeM9Q
zftDvAiYeb94/6CM9+8fjb026w==
          "]]},
        Annotation[#, "Charting`Private`Tag#217"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kksoRGEUxy9Kmcb7mYVnFqzGoyhybmFhg7AYlDIhC+URi0lWyG6aqPFI
HimZLJiFIk2nxmZGd8aUvEIe420MNfJIE809557N19f5vt855/8/mbqe+o5Q
QRByBUEInhTvaKxTT22EJImdcviwYq5MtXSSKDqlYHhRO147MNiaKBbK8YKG
C8msMSWIszPBeMLsIXejbTReJN4jNi/svT5o4ph3jxN9DW2hyzGijJNuMbrY
fmNzRDLPg8LIWYU6TMW8a/zo1ffvRIQz7wq1zukY32cI/z9H3dBq2r79F6bl
96cYVW0puTz2A9U7wvn07xrr7CMUyPwDNFdKFn37IRDPjV+6clVr6hrSfwc2
6WMDprET1Mjvd7HUah7W4S3ntzHgGrnb8j+jUb6bMWs8bz1nx4eKgoG/YLzh
IuUhg/N034Yf/l9CfMhnPuUdIHJ97g+U/oqof9jk/rtoPljh+eZofkjm+d2k
D3SzPqwfKPqxvqDoS3wPKPq7yB9IYX+o3j1Msn/sLyj+sv+g+E+8FzDyfhDP
Cy28P8TzQRXvF+8fGHj//gEseTg6
          "]]},
        Annotation[#, "Charting`Private`Tag#218"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx1+S8m3T3CsuhiJfKRfnFSV3Uq7ExcS0XayEixFy5UY0+Zjk
Ize4QRFzc2itDNMiEyEyYx+NtYVC0/ue856bp6fzPL9zzv9/8nSm5s5EQRC0
giBIJ8UHZm7Xz/wM5IpdcoRRZWg5LG7OFV1nUoSwbiKWcHylEcvlCGLkaLjw
IUUjzlul8ONGst3VF80RifeGy+7xDaNVzTwfqocsYw1JKlHGnXnR9L0vZgxm
Mu8ZSzaXHLbVVOY9YfpFtO1+Npl5j1ijr+pI6Unk/3fYdNCZ9T73C3Py+xsM
TC4aT0ZjQPU8uPppqNhb90OZzL/E3a/h9tK4B4jnxlOL1jwRWUH678T4a0Hv
jOMaS+X3dqzsWhtpHfNy3oaG/KOt0G0AJ+X7Ok439he97IRRUfAvLsU7LlMe
pjhPdxvo+X818aGI+ZR3QoDrc3+g9FdB/YOD+++m+WCT51ug+eGT53eTPqBj
fVg/UPRjfUHRl/jPUMz6n5M/YGZ/qJ4PNOwf+wuKv+w/KP4TLwgx3g/ihaCW
94d4Ycjm/eL9gzTev38flj9D
          "]]},
        Annotation[#, "Charting`Private`Tag#219"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx9/ko7WV7124W0oWabGkqPNeiGi1UC4ktJAbSSgiJS4wRZKv
XEhZKU1J9F6dvLuQmGQYGY2NDM0oF/LZ3nPec/P0dJ7nd875/4/B1lHdEiMI
glEQhOhJEUFPXmlXybtebFUijN3Dnetbe3rRfRiNF7Ro0hzGCr1YoMQzXlSt
bkp96eLiQjRCmORosg81pInEe8Ryzbhx4DeFeQ/oGYgP1NqSRQV3GESn7kru
yU5kXgAtRtdSBmiZd4tl3rYZqyGBeX4s7ri+SQ/F8H8f3tfZ4wpsPzCvvL/E
r93CydTsD6B65zj6edcubzxBvsL3oDnny1Q/cQHEO0bTYLMlK3ca6f8+7sCp
M6T1okl578KxoMefWRPkvITjhbPbEfkJp5T7Gh7MN8ZeOsOoKvj9F41XXKY8
uDlPdwlG+H8R8aGf+ZTfhxWuz/2B2p+Z+odK7r+N5oM5nm+J5gedTPMfkz7w
xvqwfqDqx/qCqi/xA2Bl/Y/IH5DYH6r3AGfsH/sLqr/sP6j+E+8ZfLwfxHsB
dX+IF4Ze3i/ePzjh/fsH2SEy3w==
          "]]},
        Annotation[#, "Charting`Private`Tag#220"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8ow2EYx38ZKSta2G5biklz8O9gp+d3WBE5zEHKYSzEYeSE6xKODjJk
2UX8wmEHIemRpbXM+hXN3wMZYWvmoJQ/037P8z6Xt7fnfT/P83y/T4V7tHMg
T5KkGkmScidFBn/dBTuOfpM8qEUaM4EOf5HdJJ9Fc5HCeNtXvmfPKDdqkcQJ
67HD91QuLy/l4hVn0sGRg5MymXgvaKu2rn64Spn3jNEZs0t/aJA1XDSBfkvr
4F6shHmP6A1veD4u9Mx7wPXGvqPbtULm3eOwe3so0aPj/3c4e+91tlf+waL2
/hp9Xdm6yfAnUL04FplrW8a3ktCg8c+x3hi09OpvgHgq2qpOr2weJ9L/CIYc
WftNdxzrtPchLFanVdWS4Pw+Tlx+L8Q233BOuysYUco2dUoahYI/2Vy8Y4Dy
EOY83fdhjP83Ex90zKd8BHa5PvcHor8m6h/s3P8QzQcGnm+F5geF51dJH5hn
fVg/EPqxviD0Jf4jTLH+MfIHFPaH6j3DGfvH/oLwl/0H4T/xkiD2g3gpuOT9
IV4axH7x/oHYv38hiDdl
          "]]},
        Annotation[#, "Charting`Private`Tag#221"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1klsow3EUx/9GyDzMdUqRRLy5LBNy/gpLoVwelJKUS3kQD0sWkcSLS61l
k6JcilaeqIWOUjKhSUgka5rL5u/yIMmt/c/5n5dfv87v9znnfL8npaWrtlUl
CEKmIAiBk+IVUxs1Y/cnWrFNDgnV6/YQ1bJWPDoMhB83vjub2lK1Yq4cPnwe
GOmprIoXZ2yBeMSh8qiLr4w4kXgPOCqlryxtxzDPi5b3hKKS2GhRxh3eobnG
4KzQa5jnwa/xAnVwayTz3OhKtpmq0sKZd4vuwVWz4SCY/1/jb95Zou/mF6zy
+0tsaHzTbTV/ANU7x2pV8U73nB9yZP4pGi2uzUXTFRDPhabSwqQ8+wT/d2KE
qTdozX6GWfL7XTwx7qNR8iDlHThU77VNWp5wSr6voL7M3Ne+IKGi4PdfIF5w
nvKQzXm6O6Cf/+cTH/aYT3knfPZRfe4PlP501D8Mc/8dNB/U8XyzND+08Pwu
0gdC9aQP6weKfqwvKPoS3wM/rP8x+QPT7A/V84KV/WN/QfGX/QfFf+L54JX3
g3h+UPaHeBKE8X7x/kEK798/z9syGg==
          "]]},
        Annotation[#, "Charting`Private`Tag#222"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl8oQ3EUx29aQ6HF2FKShz1QSixJ6lwPisfZvHjwMPmTaLIXxYMaxYt4
kJFcXkT2sGZhpY6STKEhk1r+dNfCZhNSoqbdc+55+fXr/H6fc873eyrsjvae
LEEQKgVByJwU79ixuR76aTSKvUokcWLKnjtcYBTPzzKRwPwvhxSfMYh1SsQx
8PY55PWWiMtLmXhBh37RZ5wuFon3jB+e6i6nQc+8GB4fDhjDfYWigjuLYm25
tjTq0jFPRn/MPVuSymPeE7qcD90jUg7zHnG/7MBXZNbw/wi2Lgy7gvNpcCvv
71C2QFL6/AaqF8bgxZjfMv0GtQr/Gnea7wfdkQgQL4S/G7LOpJf4/yleDrSY
Pdk3WKO8P0Kru9NWiTJSPoBVV9J208Qrzin3LRzX7O1qV5OoKviXzkQK1ygP
o5ynewBM/L+B+NDGfMqfAnJ97g/U/szUP5xw//00H9zyfCs0PyR4/hDpAzbW
h/UDVT/WF1R9iS+Dqv8F+QP17A/Vi0GQ/WN/QfWX/QfVf+LFQd0P4iUgj/eH
eEmY5P3i/QMr798/0qk4pw==
          "]]},
        Annotation[#, "Charting`Private`Tag#223"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl8oQ3EUx294UYaYNnsQL6uRPyFT1LlP3kieCMWK/GmpefIk3hCNhVlb
eBDzorxoUUd5Wm1aiMQWrsY23YlGkqbdc+55+fXr/H6fc873eyosE11DWYIg
mARByJwU76jf1rV2berFYSVkDDl2nFU2vRgMZOINA96WyauETmxQIoER/VOp
u0AnujYyEcPBmfBi8qlEJN4rzofX+8xWLfOi2N3uSO8dFYkKLvCM5XmeeF6w
kHkSfp3eWFM2DfMecdReXmvQ5jLvAd1LqVjZRg7/v8c+GOjvKBNEp/L+Fj1T
RnN8+huo3jWeVNqE42EZ6hX+Je7UZO8fVEeAeCH80chNc/m7QP/9mJ79NBWP
XWGd8v4MH7+1lt9lCSnvQ9dHW09kPI525e7F1ZfOBckpo6rgbzoTSdyiPKxx
nu4+WOH/zcSHO+ZT3g8Jrs/9gdpfI/UPh9z/CM0Hfp7PTfPDHs8fIn1ggPVh
/UDVj/UFVV/iS/DH+p+TP2Bkf6heFHrZP/YXVH/Zf1D9J14CJN4P4r2Bn/eH
eDJc8H7x/oGB9+8fanE2wQ==
          "]]},
        Annotation[#, "Charting`Private`Tag#224"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8ow2EYx3+xHcQOQ9u4yJx2kz+Fmue3VpojErWiaIuUJcLByQ6uJoSE
KHJRDg6oPTV/p80mElKbTQubbXLwr9B+z/N7Lm9vz/t+nuf5fp/SLkezLUsQ
BIMgCJmTIo15hpUm769OtEuRxPft1WHVhU70+zKRwDf/eMu3RSdWShHHkvq9
opderbgwn4lnjBxp1qy1GpF4T5jW7t8E3IXMi6H5tG1kIbtAlHC+Rww7B6wb
+WrmRdHc4XH1pVXMe8AT16xb48xhXhhnAmVg+lLw/3tUrB2rpxyCOCe9v8W9
Rs9Et/ITqN41Bs2K9da6FFRI/Ev07XyV2/pDQLwgxoyFH6PVW0D/vTi0rGzU
X11iufT+AN/vXNFfexQpv4tHxYP+sfYXnJTum2hasuQK00mUFfz5y0QKVygP
Rs7TfRcO+X8N8eGV+ZT3QifX5/5A7q+K+oc77r+H5oMQz7dI88MZzx8kfSCX
9WH9QNaP9QVZX+JHwcL6n5M/EGF/qF4MGtg/9hdkf9l/kP0nXhz0vB/ES0Ca
94d4SZD3i/cPVLx//0YaNdg=
          "]]},
        Annotation[#, "Charting`Private`Tag#225"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kksohFEUxz8KiUjjNTKJhTzKezE0OZ8SyTOmJCUNPrKRjdR4FMmCYjdm
GmLJjrIgOiFpakhNmQaL0Uge02dqlNeC5jvnns3tdu79nXP+/5NrGescipYk
qVCSpMhJEcL86dy56h69rGihYvtlS1uoSC9fuiMRROvGj824lSlXavGGrV2L
/gnMkB32SLzgftb4c81Suky8Z1R2J3eyE9OY94QZTZbl5WadrOHcj+hR18M2
cwrzAti/vzHaOJzEvAeM7c4sNwXjmefHYp1j22yO4f/3+D3grlo5kuQ17b0P
e02+BO/8F1C9G8w7mfpUokJQofE9eNhaZzC0+4F41/iafJoaN7MH9N+FH8cL
amqDB8u092e4NVISrq8NIOUP8N75585peMVV7b6Ns3cXpX0rKgoFf/8i8Y6b
lAcr5+l+AF7+byQ+2JlPeRf4uT73B6K/Kuofzrn/EZoP8nk+J80PCs9/TfpA
1CDpw/qB0I/1BaEv8QOgsP5X5A/csj9U7wmEf+wvCH/ZfxD+E+8NOng/iBcE
sT/EU0HsF+8fFPD+/QPqByx3
          "]]},
        Annotation[#, "Charting`Private`Tag#226"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kksohFEUxz80FhbyCDMLZSKPnTCN3bkrOylN0lh4RRbEktVEFDYjK4YF
JTWmEEmzmM6UQWoGUYzi8/gk8zAzCyGD0XznfGdzu517f+ec//8Ye4Zb+zIl
SaqRJCl9UiTwY6/dbNs0iH41Yph09nq3bQYR8KcjikdBw9Tgu17UqxHBn2OB
ZXl64VhMRwjr7QelQ8FiQbxXfFqqsKYsRcx7Qb9FyD32QqHi/M/Ya4i4fPP5
zFPwbTKUZb3OZd4jyjXj710tOcx7QM+q2Wja0PH/W9wxfTZX6TLEgvr+Bkf7
HfsFyS+gelcYLIg3hTsTUKfyL3HstbKtQ34A4p1jdbFpLbC1B/T/BL1RX1u5
9wJr1fcHuOnp9t2VKEh5Nyqpv93ThjDOqXcnTmePXKdmY6gpmEylI44rlIdJ
ztPdDTL/byQ+rDOf8ifg4vrcH2j9NVD/MMH9D9B8cM/zLdP8MMPzn5M+sM/6
sH6g6cf6gqYv8RWIs/6n5A/0sT9U7wXO2D/2FzR/2X/Q/CdeBH55P4gXhUPe
H+LF4Jv3i/cPvnj//gHfC0CB
          "]]},
        Annotation[#, "Charting`Private`Tag#227"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx19fNy5Iplm5oFwgK20rbnTetis3LnajLJRYUiZK3CyhcSHs
Qs0W+cgNLVfUFnUUYhkWNVu58Dlfaz6WaVNo7znvuXl6Os/zO+f8/6esvdfY
mSkIQqUgCOmT4h3HHipuh35VolmKGDqs7j71mUo88acjil+Nec0DepWoleIV
P0qMn4emYtHlTMczanTD4YtSpUi8J7TVblebnEXMi2BbeGc986xQlHD+e8zX
aJOKkwLm3eGxOVs5KOYz7wYnE1XBFncu867RsLjs3k3l8P8rRItlpb4hQ5yT
3ofxyGswPXYngeoFMR6cbZ3xvING4l+gbbJsdbPjBogXQHX5bsq/4QH670Pr
j3FiVH+ONdL7Pcwy9yyE4rdIeS82TV/228tf0C7d19DjcB1ExmMoK5j6S8cb
LlEetjhPdy8Y+X8d8eG7k/iU94GZ63N/IPeno/5hivvvovngh+ebp/khxPMH
SB/YZ31YP5D1Y31B1pf4dxBg/U/JH1CwP1QvArJ/7C/I/rL/IPtPvFeQ94N4
UUjw/hAvBk7eL94/GOH9+we9bzyu
          "]]},
        Annotation[#, "Charting`Private`Tag#228"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx19WiKKWNZaSK+zCtC0ZF+ct+UqRuZALFxhh8nHhgluJzIWv
C+Q7xSh3kqhzwYUJGzImymwtH2uMG6Ro7znvuXl6Os/zO+f8/yejscvcHC0I
QrYgCJGT4h3bw6q42HKN2CJFCDcmalNKUzXi6UkkgrjQ5Ks32lJFgxSvqN6v
26pcSRFnZyLxjIeFD1Nmi1ok3hPqvhp0Ko+KeQG0Ho/fmOOTRQl34kelR+vu
USiZ58PMPmda70oS87yoL+9VJioSmPeA/UObndfFMfz/DkfzysSd4ShxWnrv
QafRvp11+Q1Uz43F1VU5hoQw6CX+Jd76bcFPrxeI50Jnes3vVd8e0H8Hmj7y
Ciyn55grvT/A9aO286KLR6T8LppKRmxW1QuOSXc7DnasLicPhFBW8OcvEm+4
RHkY4Dzdd0HP//OJD/PMp7wDtFyf+wO5PyP1D37uv5Xmgwqeb47mh3ue30X6
wCTrw/qBrB/rC7K+xPeBlvU/I39Azf5QvQB0s3/sL8j+sv8g+0+8V5D3g3hB
WOT9IV4I1ni/eP/Ayvv3D1PSKt4=
          "]]},
        Annotation[#, "Charting`Private`Tag#229"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx18uJqFJy9iFomRqJBu5UOclN66UGSISkfJd7pa40cRaEoVc
yJ0LwtLakpNExiwipVzgZcbWfCaJaO8577l5ejrP8zvn/P8ns7Wvuj1WEIRc
QRCiJ8ULTtoCVYkOndghRwTNDY6x6yadeOyLRhgPguchuz9dNMoRwjunzjAn
pYnzc9F4xB+pweVf0orEC+L0W365RpPKvABuuXpiSss0oozz3eGHZPftFaUw
T8Icq74571fNvBs8spnbqswJzLvGyoHHjcYJFf+/woz1rHjrbow4K7+/xPf1
mdEV4zdQvQv0/HWpNuteoVDmn+GgNnn1wXILxDvB4qFarV+9DfTfiyNH/Yef
LadYIL/fxfTImsfgvEXKu3HAlK3uiHvCSfm+jDX1FZ/jwxFUFPz+i8YzLlIe
LJynuxu6+X8J8SGJ+ZT3Qi/X5/5A6c9E/cMw999J88EOz7dA84OwQfOfkD6g
Z31YP1D0Y31B0Zf4EmSz/n7yB77YH6oXgG32j/0FxV/2HxT/iReCe94P4oVh
n/eHeBGo4f3i/YMp3r9/G4o0hA==
          "]]},
        Annotation[#, "Charting`Private`Tag#230"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx9+tKPlIGrILi1rhxsc0SjmvS1woV3bhZgwXPpJyY8mNO0op
GVs+2sq4lLKis1LysWmlfA2xydfmNTfYMrT3nPfcPD2d5/mdc/7/U2Ieareo
BUEoFwQhdVLEMOzrmx7wa8UeOSS8mNV7b+1a0e9LRRQ7dEfj3Vla0SBHBNeN
js1pXZG4YEvFC0oN4krldaFIvGfctRlKm1oKmPeI1qfmsbURjSjjfA+odbmS
P115zAvj1b5T1ViWy7x7nKy4yVY7Mpl3hxmDvfHq43T+f40H+Wk7w3GVOC+/
v8SZ0V9b21QCqN4ZRlatzk/HB9TI/FOUgnqN2RsC4gUwpz95eV7nBfp/iJou
X4klGcAq+f0efoXcW0tzIaS8BzuN5sXJxAvOyHc3bte+VbVaJVQUTPyl4h2X
KQ9bnKe7B0z8v5748Mp8yh/Cj5nqc3+g9FdL/cM3999H80GM57PT/ODg+QOk
D5ywPqwfKPqxvqDoS/wwBFn/E/IHitkfqvcIE+wf+wuKv+w/KP4TLwIbvB/E
i4KJ94d4Eij7xfsHyv79AxBvPCo=
          "]]},
        Annotation[#, "Charting`Private`Tag#231"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx19jzTbaJg1bLe5YifkoHxfnVdyxC0Wu1BTJzUTS4kaNS9z5
SGILk3KhJLk4SZIaJpkwNZsWbV6UFBdo7znvuXl6Os/zO+f8/6ekx93eqxIE
oUwQhPRJ8Y7TWx1Bk8Yq9skhoW/E/VEatohnwXSkUH/zeeBrtojVciRx4Nez
nt9ZJC4upOMFXw1zu93GQpF4z6iuOBmaGjMzL4HLO7ku72q+KOOCT1i+12BX
T+cxL47XhgxTsdPIvEcMZN1L2VE986Ko9U9kNKk1/D+C/VHv76RdJc7L72/x
05z5mIz8ANULo3+0ESIPH1Al868w5rJp60viQLwQ2hz+tpbWQ6D/p+gUcgNh
Xwgr5fdHGL38sgbGY0j5fTzWDXddSC84K983MWe7cbXTI6Gi4PdfOt5whfKg
5zzd90H5X0d8uGI+5U+hlutzf6D0V0P9Q4r776f5YIPnW6L5QV1A84dIHxhk
fVg/UPRjfUHRl/hxuGP9z8kfcLA/VC8BPvaP/QXFX/YfFP+JlwQ37wfxUqDj
/SGeBGu8X7x/MMP79w/Vayld
          "]]},
        Annotation[#, "Charting`Private`Tag#232"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8ow2EYx3+t1gglabZxETuYFOaAy/M7iNSIHRTHaXLbHMwOyoFotBon
5KCl/Dm4rLTJempE02ha0RqFITNmrZB2oP2e5/dc3t6e9/08z/P9PrUWm9mq
EAShQRCEwkmRxcRH/8hjZ7U4JkUGd0oM7p3iavEiUoh31H95plumdKJRijRu
/ppcmgWtuL5WiBTeufSjPaARifeKy96y0+i2mnkv6NdOrwfPK0UJF3lC9Uwk
cOGrYF4S5yYtz032cuY9YL2yb763ppR595guiscmOlT8/xbNK43WrSGFuCq9
j+PJkW/Sos8D1btG74Nj2VSVg1aJH8O384PubmcSiBdFlTdhCHWFgP6HMWd2
Gm2DUWyW3h+j+0wlDlgfkfIBPFzMf/c8pdAj3XdxSWl37jsyKCv481eIT9yk
PCxynu4B8PP/duLDLPMpH4Ybrs/9gdxfG/UPWe5/nOaDXZ5vg+aHK54/SvrA
MOvD+oGsH+sLsr7ET4KL9b8kf0DH/lC9Fwiyf+wvyP6y/yD7T7w0bPF+EO8d
6nh/iJeBPd4v3j+45f37BxiEMok=
          "]]},
        Annotation[#, "Charting`Private`Tag#233"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kl0og2EUx19qiUZCMkoUyYiFYm7OWy40k8+WckeN15XEndzuhuRKCBEX
PtYIJSmHlhizTTKRC2wta2vzeeMj2nvOe26ens7z/M45///J7+5vM8cLglAs
CELspHhB+/yH+0zKEXvkiOCowWI0VOeIF85YhLHz9dD7s5QtVsoRwsawUW3Z
0ogz07EIose0UnojZYnEe0bV0+5yijuTeQEcsEu+umiGKOOcfsx1lR3VX6cx
z4dlhXVJneOpzHvE5HJ/nLVVzbwH9Ku7zjd6E/j/Pa4faIb3R+LFKfn9LZZ0
TFknzd9A9by4rRX8uoY3qJD5V1hk05p7j31APA/Oba+J4Tw70H8HmopPvpoS
PaiT39txIJTet9jyhJTfw4LLWtv7XRAn5Psqqn7fT9uHIqgo+PkXiyguUB7i
OE/3Pcjl/zXEB4n5lHeAnutzf6D0V0X9g477l2g+2OH5Zml+0PP8HtIHNlkf
1g8U/VhfUPQlvg/KWX8X+QN57A/VC8Ag+8f+guIv+w+K/8QLQTPvB/HCoOwP
8SIwxvvF+wfK/v0DxOc1fA==
          "]]},
        Annotation[#, "Charting`Private`Tag#234"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8ow2EYx39NsYP8WRFWatjkNuwgB8/v4E/JydFhIdaSWik7KCVRDqsp
FNoadvDnpHYah0d2wNpsDYtyGBZbbNiiRov2e57fc3l7e9738zzP9/toRi2D
4wpBEFoEQSicFB+YtpbVepfVokmKNPod3YacUS0GA4V4w3DTgjbrrxPbpXjF
7VxeNXBbK25uFCKJFSOGw7ytRiReApeuf1b1n9XMe0ZbpDWiLK8SJVwgjpoe
q9KUUTHvCR39npX1vQrmPeDNy2Sveq6UeTEccM87E/YS/n+PZ+b4+bFLIa5L
7+9w4ihbb3H+AtWLosa4UT1tzUCbxL9Cz8FJYlYZB+KFcce3ZJ+M+YD+X2BD
c1Gldi2Eeum9D4PBmZC76xEp78Xh4rHOaCSJy9J9Hx3q1GLfVBplBb/+CvGO
W5QHOU93Lwzx/w7iwynzKX8B3zqqz/2B3J+B+gcv92+m+UDH8zlofpjh+cOk
D4RZH9YPZP1YX5D1Jf4TuFj/S/IHGtkfqvcMdvaP/QXZX/YfZP+J9wq7vB/E
e4NL3h/ipSHA+8X7Bynev3+fUDpC
          "]]},
        Annotation[#, "Charting`Private`Tag#235"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kt0rw2EUx38puSDm3SxFCnNDXmoX6vz2B1AkN8pbkUK0CykuJKHdEBcz
pkRiXhK5mbcjpNgwZMW8W7KskZTFBe13znNunp7O83zOOd/vSatrLasPkSRJ
K0lS8KT4QGPLQefEqkZuUMKPd8memblujXzsCIYPO+L2o0J9yXK+Em+4VRG9
URlQy2PmYHhxanhnaXEhSSbeK673r6dqIxOZ94J9+q7bP228rOAcHjwr16lS
wmOZ94yGkpj0+20V8x6xUJ0R6J2NYN4Djq+U1kashvH/G3SFzl+bNkPkUeX9
FSYUbK9dOn6B6rlwevluNszyCXkK/wKPrPbiVr0HiOfEn2Zr03fPPtD/QxzJ
MFXPZJ9irvJ+D3f1g+aqnCekvA3rDZnuT7sXh5S7FYva3T3GNj8KBb/+gvGO
k5QHkae7Dar5v474sMl8yh9CDdfn/kD0V0D9g5P7b6T5YJ7ns9D8kMXzO0kf
uGF9WD8Q+rG+IPQl/jMI/U/IHzhnf6jeCxjZP/YXhL/sPwj/ifcGO7wfxPOB
2B/i+UHsF+8fDPD+/QOgSDey
          "]]},
        Annotation[#, "Charting`Private`Tag#236"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kktIQlEQhi9CZGAPkiyyB0VCRYtei4hg7sIWhbUoKMKEMhKJoCBoU6uC
NkG0CcokbFeLNhGEEY1kL8HsYQ8NF2mhiWIPly0K78ydzeEw53wz8/9TZZ7q
G1cIglAnCELmpPjC0NP31oRPK1qkSKHJGTZ227XitTcTSdxuml3RZWvFFikS
uHhgMO8Uloq2jUzEcVn3qAqclYjE+8D2wdhLUlfMvCie7jeOVohFooTzvqM1
rdWMVaqZ94ZF1vpEzV0B88IoKBULwUsV814xJ+9+LdeXzf9DeOUa7tQ/KMR1
6X0QGzb79w7Tv0D1ntCorz0OHv1As8T341BemVo3/Q7Eu8XKfK/NoDwH+u/B
mKsnq8vvw0bpvRsj+deB5+oIUt6JA5bJPsNFHFel+y7OV3XOlE+lUFYw/ZeJ
T3RQHuY4T3cn9PL/NuLDM/Mp74ETrs/9gdxfK/UPJu7fSvPBCM9np/mhg+e/
JX3ghvVh/UDWj/UFWV/iv4GG9feRP2Bhf6heFNzsH/sLsr/sP8j+Ey8BS7wf
xEuCg/eHeCkw8n7x/kGA9+8fzMIpqg==
          "]]},
        Annotation[#, "Charting`Private`Tag#237"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kktIQlEQhi9BtMhF9KDHbVG4kFaFBRpEczcKLnPRRiqS3tBLqoVroajA
yMCSiGoRhLWIoBCCIaNFUFoJUWCYXdFSs9eiTVB4Z+5sDoc555uZ/596+7i1
v0AQhAZBEPInxQeawwPuioQoDSiRQ5O1cCpyIEpXl/nIovgY/rTUilKzEhn0
tPv8Ol2N5FvLxysu+Lrj0/dVEvFe0F5X3OcwVjIvia7U0bato0JScJcJnOwK
VDU1ljFPxt6/vUN7rIR5cezUhURNXMO8J5zat+jichH/j+LJG/iPkwXSqvL+
AWcGb3YKS3+B6t1h60avNnb7BXqFH8H0fjS4uJIA4l1jj2F+1DBxDvT/ArUj
No/eHcIm5f0Zuracs+XVz0j5AHqdbXLi9BWXlPsupkbH0sJYDlUFv//y8Y6b
lAeZ83QPwDL/NxIfnMyn/AX8DFN97g/U/lqof8hy/0M0HwDPt07zg4vnvyZ9
IMj6sH6g6sf6gqov8WWws/4h8gcc7A/VS8Ic+8f+guov+w+q/8TLgJf3g3hZ
qOH9IV4OzLxfvH9g4v37BznxNGo=
          "]]},
        Annotation[#, "Charting`Private`Tag#238"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw1kk8ow2EYx3+NIjHamLGDdhJSGit/Ds/v4uaw5IYdFHGw1RxccCFK0iL/
hiy5KEkcRPEkJMVMllhTm83aZo02ByS03/P8nsvb2/O+n+d5vt9H32Vt7VYI
glAhCEL6pHhHdVbH2VxKJ/ZIkUDN1KGt6UQnXl+lI47O68mXviqdWCvFKx6Z
K0dvjaWiYykdUaweW7eOhLUi8SJoesq07DYXMy+MyTaLZ6ezSJRwVyHcGrzw
DjeqmRfEyKzSNxMtYF4AXfNwo0rlMs+Pxo/VgZFUFv/3YUZsHmMphbgovX/E
X79+Y6/8B6jePRraPJ3KUBIMEv8OlfkPXwvbISCeG72BEs/04TnQ/0tcTsx+
D5ldWCO9P0W7Y39cq3pGyh/g6ZTfdHwcRbt030RTTlm7sT+BsoLJv3S8oZPy
0MJ5uh/AEf+vJz5MMJ/yl2Dj+twfyP3VUf+g4f57aT5o4PlWaH7IC9D8btIH
slkf1g9k/VhfkPUlfhDirL+L/IFt9ofqheGT/WN/QfaX/QfZf+K9AvJ+EC8O
a7w/xEuAlveL9w8Kef/+ASb6PhA=
          "]]},
        Annotation[#, "Charting`Private`Tag#239"]& ], 
       TagBox[
        {RGBColor[0, 0, 1], PointSize[
          NCache[
           Rational[1, 360], 0.002777777777777778]], AbsoluteThickness[2], 
         Opacity[0.4], LineBox[CompressedData["
1:eJw9kl0og2EUx1+7cYEiZLYrljIlmtGKnNfNRC0lF0oiIcnHhd1tZUW5QImU
jxXlYik3uxzaSZrQLCIfJR/7Ym29w4WSifae8zo3T0/neX7nnP//lPSNtw+o
BEHQC4KQPineELouSiMprTgoh4TlBVaz/VQrnvnTkUBnm8k6adSKNXLE0Xe0
U7LZqBHXVtMRQxE7qhKSWiTeKy5b3r0uSxHzori+1KcuHigUZZw/jHWu5Uhz
Uz7zQlisOeh2J3OZ94zm/qAt+pPNvCcss+9aHlOZ/P8ehz+nWm6/VeKK/P4O
db/uPI8xBVTvGucrwxu90gcYZP4lzmXpRhu8YSDeOUKnbaz2xQf0/wRnMm4c
9U0BrJbfH+JsxZczmhNEyntw+qrq4W4/hgvyfRtbddaivREJ/xX8TUcSNykP
Zs7T3QOT/N9EfHAwn/In0MP1uT9Q+jNS/7DI/Q/RfLDE8zlpfjDw/OekD0yw
PqwfKPqxvqDoS/wQaFj/APkDJvaH6kVhi/1jf0Hxl/0HxX/ixeGY94N4CVD2
h3gS6Hm/WD1o5P37A9DBNZg=
          "]]},
        Annotation[#, "Charting`Private`Tag#240"]& ]},
      {"WolframDynamicHighlight", <|
       "Label" -> {"XYLabel"}, "Ball" -> {"IndicatedBall"}|>}], 
     StyleBox[
      DynamicBox[(Charting`HighlightActionBox["DynamicHighlight", {}, 
        Slot["HighlightElements"], 
        Slot["LayoutOptions"], 
        Slot["Meta"], 
        Charting`HighlightActionFunction["DynamicHighlight", {{{}, {}, 
           Annotation[{
             Hue[0.67, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTsKwkAQhhcbHwkBCR7AdHaiFnZzB48gKHZexVLFwtYjpFrBKhAlIAiC
hRIJhoSQI0h2NgM708z+zMw3j+3P17NFQwgxEEJUHq2UHXycl8oKaWt9DSvL
paX1WFlGer+rLJWe1uh+0jV4iexqrXDhl/FixvtIx+C9KY71L9nSeqvyn6Sx
34P2GSn+nerRRbQf1geUP1T5F9IY90lvlD4xnhBNrY8YB9vQPrS1niIfLCMe
AJuP6ic4P9T9V7gf8Q64P9VHeB/K1/cDdl9wDH5M+Tf8H+qP/RLomf8LrsFL
wTN4GePlbP6C7VtC/X9/uhK4Uw==
              "]]}, "Charting`Private`Tag#1"], 
           Annotation[{
             Hue[0.9060679774997897, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkc8KQUEUxicb/0t5AFnaCQu78w4eQZGdV7FEFrYeweooK4VuKaUsiEQk
j6A73/jqOJu5v76Z3zkzt9zutzoJ51zFORevqI+m8LHo+nprJvBmHddL04Hr
vp7Mx6O4HloKjOWuReO7aSGw162vmjW+C/3wnTVvfCfOh/NH8tDvP2jS9Ntz
vpr377gfS8Qc51fkqt+/5DzI5+SB5xn594K//lPkkjI8Jzfhl7TJV5Ixvojc
wPw838P9yBPcnxzhfcTOd2Ie3lfyxn9hvsX/kZzpdxP7P+5SNL6HlIzvyfnh
e5Hhe//d98P+X2vyuBU=
              "]]}, "Charting`Private`Tag#2"], 
           Annotation[{
             Hue[0.1421359549995791, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKAjEMhoODeuLBTe6ObqIObnkHH0FQ3HwVRxUHVx/BqYLTwSkHgiA4
KIooitwjyDX1hzRL+5H2S9LW++PeoEBEDSLKV4nMlGWzGdr4morjXZLHxwSO
2zbeyM9nebxMzbEsTxMp3wNsdcnd893A4ruaUPku6E/un8FTe/5kSqreEf21
rP+A87KkqCf3Y3DTnt96/jXyE8srz0dUdLyUPJcVr8Fd8Xv5mAPlS8Ed6Z//
841kPtxfyPzgVN6HdX8XsHtfDpX/Bv9e/ocrqt6Dq/p/OVK+F9eU743+xfdB
ffF9vXkz9PsDOpK36Q==
              "]]}, "Charting`Private`Tag#3"], 
           Annotation[{
             Hue[0.37820393249936934`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhcLTaJgCi9gaSdqYTd38AiCYudVLFUsbD1CqhWsBJWAIAgW
ESUYlJAjSHaWD2anmX3M7Jv9aY/no0lFKdVRSpWZo9AeL/ZTE7n2LZ9PZfxQ
75v46sDyelVGpluWOX10KHypblo2utPb8b0wj31P3RC+RNfE/gd4afrvYJ53
g69n/FfM4xSDef8R3DX9B6cegReGd45PqarlLdfJExyBh+ynmqgfyTkfeMDn
R/+M7wfe8P3RH/P7OL4E/fZ9qSH8L9Qv/D8UiHkp1eX/Uih8GbWE74v57PuB
2ZeTL3wF5v8BGoK30Q==
              "]]}, "Charting`Private`Tag#4"], 
           Annotation[{
             Hue[0.6142719099991583, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTsKwkAURQdB8mkMZAWWdqIWdrMHlyAodm7FUsXC1iWkGsEqECUgCIJF
JBIMCSFLkMwbL7y8ZuZwZ86bT3++ni06QoiBEKIZqWpl0+S81FUpx/A1aqpE
PtZVIN/vmsqVb5iGr/KYL1M9w1oXfVq+tOV7K5f5EmWx/S/wVq9/gqnfA76R
9t+R0xCjP+0PkQ/1+ksrD8AbzSfw/wW7ho+US5txAJ6SX1osDyX3xeAJnR/r
V3Q/8IHuD47pfSS/bwI27ytd5k+R3+h/pMP6ZWDzv9Jjvlz6zFfg/OQrweSr
Wr4a5/0BCTq3wg==
              "]]}, "Charting`Private`Tag#5"], 
           Annotation[{
             Hue[0.8503398874989481, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhoOg1S6F3sDRTdTB7d3BIwiKm1dxVHFw9QidIjgVqhQEQXCo
VIpSKT2CNC/+8PqW5ONPvuQl3elyMmsopXpKqWrkKnWbJ8e5qUJ3LJ+jqr7I
h6Zy5NtNVR/tW+bhrT3hy8BGF71qvhTMvqd2hS/Rjtj/AK/N+juYz7vBNzD+
K3Ie4tr+ENw360/Yz3mAfGX4gPz/gk3Le86pLTgAj9lPjshDkr4Y+YjvTy3L
C+4P+Y77Rx7z+5DsNwHb9yVX+FPkF/4f6ojzMrD9X/KE70O+8OXoh31fMPuK
mq/EfX/6o7e3
              "]]}, "Charting`Private`Tag#6"], 
           Annotation[{
             Hue[0.08640786499873876, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhoOg1Q4VegNHN1EHt9zBIwiKm1dxVHFw9QidIjgVqhQEQXCo
VIqlpXgEaV784eUt6cf/+iUv6c1W03lDCNEXQtQr1Ve16eO00FWBL1FdJXik
qwDvtnXlyjdMy0d5zJeprmGti97KYb7U8r2Uy3wJ+un/J3ij+x9g2u8O31D7
b8hpia3/Q/BA95+tPACvNR/h/99g0/CBcukwDsAT8ssWy0PJfTH6x3R+9C9p
PuR7mh95TPcj+bwJ2NyvdJk/RX6l95Edtl8GNu8rPebLpc98BeYhXwkmX2X5
vjjvD+w7t64=
              "]]}, "Charting`Private`Tag#7"], 
           Annotation[{
             Hue[0.3224758424985268, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRfBxBRpcgNLO1ELu72DRxAUO69iqWJh6xGsVrASogQEQbBQ
FIkYQo4g2b9+mEwzeczsm91JczgdjGpKqZZSqsyIwvj42I1t5Kbh+BiXkZG7
Nr7k5aKMj4kcI6UmFL432eriF+fB96z4HiYQvjv7cf5mPMdz238lY96Fvo71
n1lHSujD+QO5bfv3lfqWPLO8of+/wbrjNeraF7wl9+HXnqgftPQl7O/h/uyf
4H3kFd5PTrAfLd97p8/tVwfC/2T9hP/D+2Deu3K/VIfC99GR8H3ZD19GP3x5
xVew/gPYS7ee
              "]]}, "Charting`Private`Tag#8"], 
           Annotation[{
             Hue[0.5585438199983166, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRfBmBQ2uYGlnaiF3dzBIwiKnVexVLGw9QipVrASVAKCIFgo
iiQkhBxBsrP5MDvN5DE7b3Y2ncliPG0opbpKqSpzlLrFH4eZiQJ8OVeRa9/y
wEQG3qyrSHVomVOi28L3Axvd+Qs/+z6O760D4XtpT/Q/wStz/gHmeXf4+sZ/
Q51TjPncf0K9Z84fnXoEXhrew1+/YNPyjuvkCY6o7h+x36mfULf3Aw/5/lT7
57wf+re8Pzjm9yG57wts35cC4f9g3pX/D/li3o/kvgm1hS+lUPgyx5eD2Vc4
vhL7/wHOW7eW
              "]]}, "Charting`Private`Tag#9"], 
           Annotation[{
             Hue[0.7946117974981064, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoNgrUMHfQNHN1EHt7yDjyAobr6Ko4qDq4/QKYJToUpBEASH
SqVYWkofQZpLf7jccvm43JfkMlhs5suWEGIohKgzRaU6tLisdJTgW1hHAZ7o
yJVr+LCvI1N9w5R+ymO+FKx14dfyJZbvo7rMFyuH9b/BO73/BabznvCPtf+B
OqUIdeoPUB/p/VfL74O3ms/obybYNnyiunQY++AZ+a16ILkvAk/p/rLxr+l9
6D/S+8ERzUfy98ZgM1/ZZf4E593pf6TLzkvB5n+lx3yZ7DFfbvkKMPlKy1fh
vn/Ei7eO
              "]]}, "Charting`Private`Tag#10"], 
           Annotation[{
             Hue[0.030679774997896203`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhoNgbaGCHsHRTdTBLXfwCILi5lUcVRxcPUKnCE6FKgVBEByU
ilhaSo8gzUt/eHlL+vEn30tee7PVdN4QQvSFENVKVaoWfZwWugrwJaoqB490
ZeDdtqpUdQ3T8lM+831V27DWRR/LlyiX+d7KY76Xctj5p2oa3uj9DzD1u2P/
UPtvyGmJkdP5EPlA7z9beQBeaz7i/vUE6/MHyqXDOABPyG/loeS+GPmY7i9r
/5Leh3xP7wfHNB+wmR/YzFd6zJ+g/5X+D5j6faXLfD/pM18qO8yXWb7c8hWW
r8R9/7GDt4E=
              "]]}, "Charting`Private`Tag#11"], 
           Annotation[{
             Hue[0.266747752497686, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRfBJEUQr2BpJ2phN3fwCIJi51UsVSxsPYLVClaBKAFBECwU
JSQkhBxBspN8mJ1m8/g7b2c3vdlqOm8ppfpKqWrlKrXLH+eFqQJ8DavKwSNT
GXi3rSrV3Zp5SbQvfDHY6MKf5ftavo/2hO+tHdH/0u2aN2b/E8znPbB/aPx3
5LxEyLk/QD4w+y9WfgKvDR/BzQs2/QfOyRF8Ak/Yb+UBucIXIR/z/NT4l3w/
5Hu+Pzji9yE53xtcvy95wv9FfuP/g3n4vJjk/0jIF76UOsKXoZ99ueUrLF+J
ef+mC7d4
              "]]}, "Charting`Private`Tag#12"], 
           Annotation[{
             Hue[0.5028157299974758, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoOo7SB9B0c3UQe3ewcfQVDcfBVHFQdXH6FTBCdBpSAIgkOl
IpaW0keQ5tIfLrckH3f35ZJ0p8vJrKGU6imlqpWj1G3eHOcmCu1Zvl6qyMFD
Exl4u6ki1YFlXn66I3xfsNFdPjiPfYnje2tf+GLUc/9LtyyvTf0TzOc9UD8w
/jvyvETIc/8Z+b6pPzn5ELwyfADXL1j37zlPbcEheMx+kvVn8oQvQv2I56em
5QXfD/07vj844vchOV8Mtu9LvvAnyN/4fzAPn/cl+R8/6ghfSoHwZY4vd3yF
4ysx7x+ZA7dv
              "]]}, "Charting`Private`Tag#13"], 
           Annotation[{
             Hue[0.7388837074972656, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhfRKERyB0s7UQu7uYNHEBQ7r2KpYmHrEVKtYBWIEhAEwSIS
CZGIeATJzvrB7DS7j2/27V9nshhPa0qprlKqGrm+2uPJYWbqo5uWT3FVb/DA
VAnerKt66cAyD4X2hS/XbctGFz+xH/syx/fQLeFL0c/r77pheWX6b2De74r+
vvFfkPOQOOsjcM/0H7Ge8xD50vAe+f8F//mOc/IEh+AR+0n2R9QUvgT5kM9P
dctzvh/yLd8fnPD7kDxfCrbvSy3hz5Cf+X/AvF9O8j8K8oXvRYHwlY7v7fg+
ju+L8/4Akdu3aA==
              "]]}, "Charting`Private`Tag#14"], 
           Annotation[{
             Hue[0.9749516849970554, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KAkEMhQfxD0TvYGknamGXO3gEQbHzKpYqFrYeYasRrIRVFgRBsFAU
cdlFPILsvPVBJk3m4yVvJpnmcDoYFYwxLWNMlhFfW8ZhO3bxIR/CLFJy10Vi
KzkvF1nEtpEz0tvWlN+L7OzCp+f3IMPvTn+kmy2p/it57uovZNx3pl/H+Z+o
I0Ve/57cdvU79kMPqM8cb6j/N/jX19ClrDgg9+Evun4vet6Ieg/vl2LOE8xH
fYX5yRH2I/p9N+r5fnkf/B+sP+J/yLjvJVX9v1JTfrHUlV/i+aWe38eb98v3
/gCDS7de
              "]]}, "Charting`Private`Tag#15"], 
           Annotation[{
             Hue[0.21101966249684523`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhcxSSE5hKWdqIXd3MEjCIqdV7FUsbD1CKlWsApECQiCYBGJ
hAQl5AiSneSD2Wl2H9/um/3pz9ezRUcpNVBK1SNXpV2enJemSvA1qusHHpv6
aq/h/a6uQvsN85DrnvBlYKOLPpYvBbPvDT8PiXbE/hd4a9Y/wdzvAd/I+O+6
K3yxtT8ED836i5UH4I3hE/ztC7b+I+fkCg7AU/aTI/KQpC9GPuHzU+tf8f2Q
H/j+4Jjfx/IlyJv3JU/4U+Q3/h8w98tI/kdOPeEryBe+L/qz7wdmX2n5Kpz3
D3ort1Y=
              "]]}, "Charting`Private`Tag#16"], 
           Annotation[{
             Hue[0.44708763999663503`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhfRBCI5hKWdqIXd3sEjCIqdV7FUsbD1CFYrWAWiBARBsIhE
QkJCyBEkO9kPZqfZfczMm/0ZLDbzZUcIMRRCNCtFrRzaXFc6KvA9bKIET3QU
ym35sG8iV37LtGTKY75U9VvWuvBn+RIw+b7w0xKrHuv/gHe6/g2meS/4xtr/
VF3mi6z+ADzS9TcrfwFvNZ/hNy9o/CfKS4fxRZr+GfnBlA8k90XIT+n80vjX
dD/wke6P+ojex/LFyLfvK13mT5B/0P+AaV4q+X9k0mO+XPrMV2A++UrLV1nn
q8F/dVu3UA==
              "]]}, "Charting`Private`Tag#17"], 
           Annotation[{
             Hue[0.6831556174964248, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb8KwjAQh4NoC/55CEc3UQe3ewcfQVDcfBVHFQdXH6FTBKdClYIgCA6V
SmlpKX0EaS79QXJL8nF3Xy7JcLldrFpCiJEQol45KtnhzXWtopSO5ntQRwGe
qsjBx0MdmRxo5iWVXcOXyJ5mpQt+li+2fF/pGr4I83H/R7Y171X925r/BZ4o
/xP1vIRWvw8eq/ob+jnvIb9TfMG8zQs2+TPnyTHYo8Y3Zz+Y8z6ZvpAa34zn
B2/4fuAT3x8c8vtYvgjn6fcl1/DHyD/4f8B8XkLmf6TUNXwZ9Q1fjvPZV1i+
0pqvAv8BZlu3Rg==
              "]]}, "Charting`Private`Tag#18"], 
           Annotation[{
             Hue[0.9192235949962146, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoNYi6Uv4egm6uCWd/ARBMXNV3FUcXD1ETpFcCpUKQiC4KBU
SktL6SNIc+kPl1uSj0u+3F0Gi8182RFCDIUQzUpRK4c2l5WOSvUM36ImSvBE
RwE+7JvIlW+Ylkx5zJeqvmGti36WL8H75Psql/k+yNP9t+oa3unzL6v+J3is
/Q+cpyW27ofgkT5/xX3KB8hvNZ9RfzvBNn+ivHQYB+AZ+a18KLkvlq1vSvWD
19Qf+Ej9g2OaD/xmftKar3SZP0H+Tv8DpvdSyf8jkx7z5dJnvgL9kK+0fJXV
b416/1vDtz8=
              "]]}, "Charting`Private`Tag#19"], 
           Annotation[{
             Hue[0.15529157249600445`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoNYi6Uv4egm6uCWd/ARBMXNV3FUcXD1ETpFcCpUKQiC4KBU
SktL6SNIc+kPl1suH5d8yV0Gi8182RFCDIUQTaaolUOLy0pHpXqGb1ETJXii
owAf9k3kyjdMKVMe86Wqb1jroh/uI18CJt9Xucz3QZ3Ov1XX8E7vf1nvf4LH
2v/AfkqxdT4Ej/T+q1UPwFvNZ/TfTrCtn6guHcYBeEZ+qx5K7otl65vS+8Fr
6g98pP7BMc0HfjM/ac1XusyfoH6n/7HuSyX/j0x6zJdLn/kK9EO+En7yVVa/
Nd77B1e7tzw=
              "]]}, "Charting`Private`Tag#20"], 
           Annotation[{
             Hue[0.39135954999579425`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhoNaxeIlHN1EHdzeHTyCoLh5FUcVB1eP0CmCU6GKIAiCg1IR
xVI8gjR//CF5S/rxv355SZrD6WBUUkq1lFLFivrqAB/bsalcVy3vk6IyctfU
h7xcFPXWDctYXjp0fE9dt2x0yYP7wZeS4bvTj+XGHP9fdcXy3PRfvPnP5I7x
n9iP5ej9H5Pbpn/n5RF5ZnjjzafUP18jl8DhiNyHX9z+mLmdj3kP80vZ8gTn
Y77C+clH3I/nu4l3v1J1/CnzA96HPuz3lJr7vhI6vrc0HN+Hfvgy+uHLxb2/
L+f9AVIjtzc=
              "]]}, "Charting`Private`Tag#21"], 
           Annotation[{
             Hue[0.6274275274955841, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKAjEQRYO6C65ewtJO1MJu7uARBMXOq1iqWNh6hK0iWC2oLAiCYLGi
iKLIHkE2P35Ippk8ZvIySRqDSX9YUko1lVJFRuS6gsVmZOKrA8v7XREfHVru
mHiTF/MiXrpuGempI8f30FXLRre70w/fjQzflX6kjHXsv3Demek/e/Of2N82
/iPrSKm3PyG3TP/Wq8fkqeE1/f8X/NdXqEvgcEzuwS9ufyKuL2W9i/mlbHmM
+7G+xP3JKd7H82Xiva+Ejv/G/Qf8DxnnPcT9j6dEju8lNcf35nnwfcjwfT1f
znl/SJO3Lw==
              "]]}, "Charting`Private`Tag#22"], 
           Annotation[{
             Hue[0.8634955049953739, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhoPagu0pHN1EHdxyB48gKG5exVHFwdUjOEVwKlQpCILgUKmU
lpbSI0jz0h9e3pJ8/MmXl2Sw2MyXHSHEUAjRjFS16tHkutJVKcfwPWyqVK7h
ia4CfNg3lSvfMA2Z8pgvVX3DWhf+4CdfAibfF34aYvRH+z/gnV7/tvp/wTfW
/qfqMl9k7Q/AI73+ZuUX8FbzGf72Bdv8RLl0GF/AM/JLvj6Q3Bchn1L/su1/
TfdDfqT7gyN6H8sXIzfvK13mT5A/6H/AdF4q+X9k0mO+XPrMV+B88pWWr7J8
Nfr9A0Hrtyo=
              "]]}, "Charting`Private`Tag#23"], 
           Annotation[{
             Hue[0.09956348249516367, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhoPagvQUjm6iDm7vDh5BUNy8iqOKg6tHcIrgVKhSEATBoVIp
LRXpEaR5zQ8vb0k+/uTLS9KbrabzllKqr5SqR65Kd3hyXpj6aa/ha1TXV/sN
j0yV4N22rkIHDfOQ667wZWCjiz7wsy8Fs+8NPw8J+uP9L/DGrH86/T/gGxr/
XbeFL3b2h+CBWX9x8hN4bfgIv31Bmx84J0/wiWw+YT/J9SFJX4x8zP2T7X/J
90O+5/uDY34fx5cgb96XfOFPkd/4f8B8XkbyP3LqCl9BgfCVOJ99X8f3c3wV
+v0DPjO3Jw==
              "]]}, "Charting`Private`Tag#24"], 
           Annotation[{
             Hue[0.3356314599949535, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT8KwjAUh4N/itBTOLqJOrjlDh5BUNy8iqOKg6tH6BTBqVClIAiCQ6VS
WpTSI0jzS3+QvOXl4+V9eUn68/Vs0RJCDIQQdUZUqoPFeamjVF3D16iOn/IM
j3V8yftdHYXyDSPlqmf5MrLWRR/64UvJ8L3pR0o4H/pfqm14q/c/nfkf9I20
/879SLHTH7J/qPdfyKgH5I3mE/3NCzb1I+rS5oA8hd+ph9L2xbKZb4L5ySvc
j/0H3J8c430cX8K6eV/pWf6U9Rv+h4zzMmn/Ry57lq+QvuX78nz4fo6vdHwV
638z07cf
              "]]}, "Charting`Private`Tag#25"], 
           Annotation[{
             Hue[0.5716994374947433, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoPWUuhTOLqJOrjlHXwEQXHzVRxVHFx9hE4RnApVCoIgOFQq
paWl9BGkufSHyy2Xj7t8uSTD5Xax6gkhRkKINlM0yqHFda2jVgPD96iNCjzV
UYKPhzYK5RumlCuP+TKw1kU/y5davq9ymS/BfLT/o/qG97r/bc3/gm+i/U/0
U4qt/SH2j3X/DUz1ALzTfIG/e8HOd6a6dBgH4Dn5rXoINvPJzjej+cEbuh/6
T3R/cEzvI/l8CermfaXL/CnqD/ofMJ2XSf4fufSYr5A+85U4n3yV5astX4P7
/wEsw7cb
              "]]}, "Charting`Private`Tag#26"], 
           Annotation[{
             Hue[0.8077674149945295, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoPWUvoWjm6iDm55Bx9BUNx8FUcVB1cfoVMEp0KVgiAIDpVK
aWkpfQRpLv3hckvycZfvLslwuV2sekKIkRCiXSka5dDmutZRq4Hhe9RGBZ7q
KMHHQxuF8g3TkiuP+TKw1kU/9CNfavm+ymW+BPV0/qP6hve6/m3N/4Jvov1P
1NMSW+dDnB/r+huY8gF4p/kCf/eCne9MeekwDsBz8lv5EGzmk51vRvODN3Q/
1J/o/uCY3kfy+RLkzftKl/lT5B/0P2Dql0n+H7n0mK+QPvOV6E++yvLVlq/B
/f8oG7cY
              "]]}, "Charting`Private`Tag#27"], 
           Annotation[{
             Hue[0.04383539249432289, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhd/QsgtLO1ELez2Dh5BUOy8iqWKha1HSLWClaASEATBQlEk
Ygg5gmS/zQez00weM/sys9sazYbjmlKqrZQqM6IwDXzsJjZy8ulYRmaajns2
fuTVsoyviRwjpSYUvg/Z6o5v+uF7keF7mkD4Hqzj/N3UHS9s/82b/0ruWv+F
/UiJd/7A/o7t35NRj9k/t7zl/tUNVvUN6rohOCYP4PfqB7KbT1e+PuYnT7Ef
eY39yQnux/M9tHe/OhD+F8+f8T7sx/8+Wu6b6lD4vjoSvh/74cs8X67l+xac
9w8dM7cP
              "]]}, "Charting`Private`Tag#28"], 
           Annotation[{
             Hue[0.27990336999410914`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhoPWIt7C0U3UwS138AiC4uZVHFUcXD1CpxScCioFQRAcKpXS
opQeQZo//SF5S/rx/nx9Sfrz9WzREkIMhBD1iqqUh49wqaskXy91/VTH8FjX
l7zf1VWonmEsuepavoysdZcP/fClZPjeyrd8CfvY/1Jtw1udfzrzP8gj7b8z
jyV29kfMD3X+TEY/YH6j+cTzNzfY9I/oS8/igDyF3+lHZDOfbHwTzC/NW4Ur
nI98wPmZj3E/ji+Rzv1K3/Kn3H/D+zCP/2XSPm8uu5avkD3L92Uevp/jKx1f
xXn/G1u3DA==
              "]]}, "Charting`Private`Tag#29"], 
           Annotation[{
             Hue[0.5159713474939025, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRReNQXILSztRC7u9g0cQFDuvYqliYesRUm3AKhAlIAiCRSQS
EhJCjiDZ2XyYnWbzmJmXmd3Rardc94QQYyFEe1I0yqGPYKOjBt+jNio1MDzT
UYJPxzYK5RmmI1dD5svAWhf94CdfCibfV7nMl6g+6/+AD7r+bc3/Ak+1/4l6
OmKrP0T9RNffwJT3Ub/XfMX+3Q12+QvlpcPYBy/Ib+VDsJlPdr45zS/NWwVb
2g98pv1RH9P9WL4EeXO/0mX+FPkHvQ/66X+Z5Pvmcsh8hfSYr0Q/+SrLV1u+
BvP+ARiTtwk=
              "]]}, "Charting`Private`Tag#30"], 
           Annotation[{
             Hue[0.7520393249936888, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhoPWCt7C0U3UwS138AiC4uZVHFUcXD1CpxScCioFQRAcKpXS
opQeQZo//SF5S/LxXr68l/Tn69miJYQYCCHqFVEpD5twqaMkXy91/FTH8FjH
l7zf1VGonmEsuepavoysdZcP/fClZPjeyrd8iWpb51/kra5/Ov0/yCPtv7Me
S+ycj1g/1PVnMvIB6zeaT5y/ecEmf0ReehYH5Cn8Tj4im/5k45ugf2n+Klxh
PvIB87M+xvs4voR5877St/wp8zf8Dxn3ZdKeN5ddy1fInuX78n74fmT4SsdX
sd8/E2O3BQ==
              "]]}, "Charting`Private`Tag#31"], 
           Annotation[{
             Hue[0.9881073024934821, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhd/IuQWlnaiFnZ7B48gKHZexVLFwtYjpNqAVSBKQBAEi4gi
ESXkCJL9kg9mp9l9zMzb3dnudDmZNZRSPaVUuSIK08ImnNvIyae4jJ9pVzy0
8SVvN2V8jF8xlsx0hO9Ntrr4RT98TzJ8D+MJX2qaov9OXtv6m3P/K3lg/RfW
Y0mc/ojct/VHJx+QV5YP9NcTrPN75LXkQNf1Y/jJyEda+hL2j3B/Xf1VuMD7
yDu8n/UJ5uP4Uuar+WpP+J/Mn/E/ZJz31m3hy3RH+D7aF74vz4fvR4Yvd3wF
7/sHDdO3AQ==
              "]]}, "Charting`Private`Tag#32"], 
           Annotation[{
             Hue[0.22417527999326836`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRc1EXILSztRC7u5g0cQFDuvYqliYesRUm3AKhAlIAiCRSQS
EpSQI0h2kg+z02wef/bt7Gaw2MyXHaXUUClVr1yV7vFHsDJVgq9RXT/tNDwx
9UV+2NdVaK9hXnLdF74MbHTRB/vZl1q+t3aFL9Fdsf8F3pn+pzX/Azw2/jv6
eYmt/SF4ZPovVu6Dt4bP8Lcv2OYnzkmyT23/jP1gzkOy5gNPeX5q/lWw5vuB
j3x/9Mf8PiTnS5A370uu8KfIb/x/wHxeRo7w5dQXvoI84fvifPb9wOwrLV+F
ef8Kc7b/
              "]]}, "Charting`Private`Tag#33"], 
           Annotation[{
             Hue[0.4602432574930617, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRZeYEHIMSztRC7u9g0cQFDuvYqliYesRUq1gFYgSEATBIhIJ
CQkhR5DsbD7MTjP7+TNvZ2eHy+1i5QghRkKILlO0akCH61pHo1yj73EXtfKM
nuqo4B8PXZQqMJpSoXzGy6E1Lv7hPuJlFu+L+yilqKf+D/Re17+t+V/gTTT/
qRzGS6CpP0L/WNffLH4IvdP6An6/wd4/ky+5DqHnxJcu8yP4Zj7Zzzej+aE3
9D7oE70f/QntR/L5Uvhmv9Jj/Az+g/4Hmu7LLV4hfcYrZcB4FeqJV1u8RvL/
bfH+P/jktvE=
              "]]}, "Charting`Private`Tag#34"], 
           Annotation[{
             Hue[0.696311234992848, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhkO1lT6Go5uog1vewUcQFDdfxVHFwdVH6BTBqVClIAiCQ6VS
WlpKH0GaS3+43JJ83N2XSzJcbhcrRwgxEkK0K0WjerS5rnXUqm/4HrVRgac6
SvDx0EahfMO05MpjvkwNDGtd9MN55Est31e5zJegnvo/4L2uf1vzv+CbaP9T
OcwXg6k/RP9Y198sfwDeab7A371glz9TXnIOwHPyW/kQbOaT3Xwzmh+8ofuB
T3R/9Mf0PpLPlyBv3le6zJ8i/6D/AdN5meXLpcd8hfSZr0Q9+SrLV0v+vw3u
/wfy1Lbt
              "]]}, "Charting`Private`Tag#35"], 
           Annotation[{
             Hue[0.9323792124926413, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoPaSh/D0U3UwS3v4CMIipuv4qji4OojdErBqVClIAiCQ6VS
WlpKH0GaS3+43HL5uMuXSzJa7ZbrnhBiLIRoM0Wj+rQINjpqNTB8j9qowDMd
Jfh0bKNQnmFKuXKZL1NDw1oX/XAe+VLL91UO8yXop/0fZWYPDrr/bc3/Ak+1
/4l+SrG1P0T/RPffwFT3wXvNV8zbvWDnu1Bd9hn74AX5rXoINvPJzjen+cFb
uh/4TPfH/pjeR/L5EtTN+0qH+VPUH/Q/YDovs3y5dJmvkB7zlegnX2X5asn/
t8H9/+38tuo=
              "]]}, "Charting`Private`Tag#36"], 
           Annotation[{
             Hue[0.16844718999242758`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhd/cw1LO1ELu72DRxAUO69iqWJh6xGsNmAViBIQBMEiooSE
hJAjSPbbfLA7zeYxM29nJ4PFZr5sCSGGQoj6RFSqjQ9/paMk38I6CtUxPNGR
kw/7OjLlGcaRqp7lS1TfsNaFP/rh+zq+j+pavpj16H8rM7u/0/UvZ/4neaz9
D9bjiJz+gPUjXX8lI38hbzWfOW+zwcZ3Ql62Lb6QZ/A7+YBs5pONb4r5yWu8
j3zE+9kfYT/Sni9m3uxXdi3/l/k7/g8Z9yWOL5U9y5dJz/LlrIevcHyl46v4
/j/o3Lbm
              "]]}, "Charting`Private`Tag#37"], 
           Annotation[{
             Hue[0.40451516749222094`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb0KwjAUhYO/fQ1HN1EHt7yDjyAobr6Ko4qDq4/glIJToUpBEASHilJa
WkofQZqTHkjukn7cky836WCxmS9bQoihEKJeUZVq48Nf6SrJt7CuQnUMT3Tl
5MO+rkx5hrGkqmf5EtU3rHXhj374vo7vo7qWL2Ye+9/KzO7vdP7lzP8kj7X/
wTyWyNkfMD/S+SsZ/Qt5q/nMeZsXbHwn9GXb4gt5Br/TD8hmPtn4ppifvMb9
yEfcn/sjvI+054vZN+8ru5b/S98d/4d5nJc4vlT2LF8mPcuXMw9f4fhKx1fx
/n/oVLbl
              "]]}, "Charting`Private`Tag#38"], 
           Annotation[{
             Hue[0.6405831449920072, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRZfEYK5haSdqYbd38AiCYudVLFUsbD1CqhWsAlECgiBYRCIh
EpEcQbJ/82F3mtnHzP87s9ubraZzTwjRF0I0GVErH4fTQsePfEma+KqO4ZGO
irzbNvFRoWGkUgWWX6G6hrVd8lae5Zc7fi/qkTLOA/2T+o3uf5Bx3539Q+1/
Yx0pdfQxeaD7z9SjHpHXmo+ct33BVn9AXfoWR+QJ/KXdH7Nu5mN9jPnJS+xH
3mN/cor3kfZ8Gf3N+8rA8s+pv+J/2I/7CsevpN78vwwtv4r98Ps6fj/Hr+b+
f958tt4=
              "]]}, "Charting`Private`Tag#39"], 
           Annotation[{
             Hue[0.8766511224918005, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRZfESK5haSdqYbd38AiCYudVLFUsbD1CqhWsAlECgiBYRCIh
EpEcQbJ/82F3mtnHzP87s9ubraZzTwjRF0I0GVErH4fTQsePfEma+KqO4ZGO
irzbNvFRoWGkUgWWX6G6hrVd8lae5Zc7fi/qkTLOA/2T+o3uf5Bx3539Q+1/
Yx0pdfQxeaD7z9SjHpHXmo+ct33BVn9AXfoWR+QJ/KXdH7Nu5mN9jPnJS+xH
3mN/cor3cfwysnlfGVj+OfVX/A/7cV8h7X1L6s3/y9Dyq9gPv6/j93P8as77
B9ucttw=
              "]]}, "Charting`Private`Tag#40"], 
           Annotation[{
             Hue[0.1127190999915868, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRReTiNewtBO1sNs7eARBsfMqlioWth7BagWrQJSAIAgWkUiI
JIQcQbJ/82F3msljZt7Obvrz9WzREUIMhBBNRtTKfF+WOirlGb5FTZTksY5C
+Yb3uyZ+qmcYKVeB5ctU17DWRV+eB1/q+D6cR0rYj/k3eav7X87+T+470v4H
60ixMx+Sh7r/ynnUz+SN5hO5fcF2/oi69Cw+k6fwS7s/lLYvZn2C/ckr3I98
wP3JMd7H8SWsm/eVgeVPWb/j/3Ae52XSt3w5583/lz3LV7AfvtLxVY6v5r5/
0sS21w==
              "]]}, "Charting`Private`Tag#41"], 
           Annotation[{
             Hue[0.34878707749138016`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTsKwkAURQeT6Dos7UQt7GYPLkFQ7NyKpYqFrUuwGsEqECUgCIJFJBIi
CSFLkMydXJh5zcvhzjvzSX++ni06QoiBEKLpqFqZ78tSV6U8w7eoqZI81lUo
3/B+19RP9Qyj5SqwfJnqGta66Mv94Evph+/DebSE6zH/Jm/1+pdz/id9I+1/
MEeLnfmQPNTrr05+Jm80n+hvX7DNj8ilZ/GZPIVf2utDafti5hOcn7zC/cgH
3J8c430cX8LcvK8MLH/K/I7/w3nslzm+nPPm/8ue5Sukb/lKx1cxR6vp/wPK
5LbR
              "]]}, "Charting`Private`Tag#42"], 
           Annotation[{
             Hue[0.5848550549911664, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRdDzDks7UQt7PYOHkFQ7LyKpYqFrUdItYJVIEpAEASLSCRE
EkKOIJnZfNiZZvbzZ97szg4Wm/myp5QaKqXazNEYe76sKGrjWX2L26igJxQl
9GHfxs8EVnMqjO/wctO3mnDxF/OYlwneB/2cUtRz/xt6R/Uvcf8neGPiP+Bz
SkR/BD2i+qvwQ+gt6TP43QY7/8S+9hwd6s6fMV+79ZF2eQn8Kd8fes3vgz7y
+6ET3o/gpfDtfrXv8DP4d/4f9PO8XPAK9Nv/14HDK1HPvErwasFrMP8Pxwy2
zA==
              "]]}, "Charting`Private`Tag#43"], 
           Annotation[{
             Hue[0.8209230324909598, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhcluYelnaiF3d7BIwiKnVexVLGw9QipVrAKRAkIgmARiYRI
QsgRZGc2H+xMM3l8s29/Mlhs5sueUmqolLKdqzXu+7Kiakzf8S2xVYMnVBX4
sLf1M6FjbqUJPF+BnHTJF/uxLxe+D9ZzyzDP69/gHc2/xPmf8I3J/0DOLRXr
Y/CI5q8ij8Bb4jP83Qt2+Ylz7XMEnrFf5LH2fSnyKZ8fvOb7gY98f3DK7yN8
GXL3vjrw/DnyO/8fsV8hfCXWu/+vQ89XYZ59tfA1wtci/wPCpLbH
              "]]}, "Charting`Private`Tag#44"], 
           Annotation[{
             Hue[0.05699100999074602, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRldNcg9LO1ELu72DRxAUO69iqWJh6xFSrWAViLIgCIJFJBIS
EkKOINnZfLAzzeTxzb79yXC5Xaz6QoiREKLtVI2y39e1qRp8j9uq1MDy1FQJ
Ph7aKlRgmVqufMeXITe6+Ac/+VLm+yrP8SWYp/Uf8N7Mv9n5X/BNjP+JnJpm
6yPw2MzfWB6Cd4Yv8Hcv2OVnyqXLIXhOfpZH0vVp5DM6v+xZ3tD9kJ/o/mBN
78N8CXL7vtJz/CnyB/0fMO2XMV8ufcdXyMDxlZgnX8V8NfM1yP+8tLbD
              "]]}, "Charting`Private`Tag#45"], 
           Annotation[{
             Hue[0.2930589874905394, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRVcN3sPSTtTCbu/gEQTFzqtYqljYegSrFawCUQKCIFhEIiGS
EDyCZP/mw840s58/83ZntjdbTedtpVRfKVVnxM+483lho6K+RnWUpuP0yEZB
vdvW8TVdp5FyE3i8jL7FRR/ywUsF781+pIT16H9Rb2z907S8+x7kDS3/znqk
WPSH1ANbfxH+iXpt9ZH8ZoONf4CvfX2inoAv/FD7vJj+GO/XzXxLzEd/j/mp
Y+xH8BL6br868Pgp/Rv+hxr3ZYKXs9/9v+56vIL14JWCVwnej/4fuFy2wA==

              "]]}, "Charting`Private`Tag#46"], 
           Annotation[{
             Hue[0.5291269649903256, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRVcNuYelnaiF3d7BIwQUO69iqWJh6xFSrWAViBIQBMEiEgmR
hJAjSPZvPuxOM/v4M39ndofBZrHsCyFGQog2IxplzpeVjpp8i9uo1MDwVEdJ
Puzb+CnfMFKhPMsvp67t4i/94Zc5fh/2I6WsR/+bvNP1L9Wz7ntSn2j/Bxkp
cfoj8ljXXx09JG81nzlv94KdfoIubQ7Jc/g7eiRtv4T6DPPLbr819qN+xP7k
BO8j7X1Tsnlf6Vn+GfU7/oeM+3JnvoL95v+lb/mVrIdf5fjVjl/Def+17La+

              "]]}, "Charting`Private`Tag#47"], 
           Annotation[{
             Hue[0.765194942490119, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSrWAViBIQBMEiooRI
QsgRJDubDzPTzD7+zN+Z3f58PVt0lFIDpVSTKWrjzueljQp8jZsoTdfx2EYB
3u+a+JnAMaXc+MwvMz3H1i7+wp/8PsLvjX5KKeqp/wXe2vqn8dh9D+gj638H
U0pEfwQe2vqL0EPwxvIJ87Yv2OpH0jXnEDwlf+0xPdLcL0H9hOZH/Yr2g36g
/cEJvY/m+6Zg977aZ/4f6Df6HzDdl4n5cvS7/9cB8yuEXyn8KuFXY94/snS2
uw==
              "]]}, "Charting`Private`Tag#48"], 
           Annotation[{
             Hue[0.0012629199899052423`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSrWAViBIQBMEiooRI
QsgRJPs3H3anmX38mb8zu/35erboCCEGQogmI2plzueljop8jZsoVdfwWEdB
3u+a+KnAMFKufMsvUz3D2i7+0h9+H8fvzX6klPXofynP8FbXP8m478H6kfa/
U0dKnP6I9UNdfyFDD8kbzSfO275gqx+hS5tD8hT+0rP0iLqZj/oE85NX2I/1
B+xPPcH7OH4p2byv9C3/D/Ub/oeM+zJp75uz3/y/DCy/wvErHb/K8as57x+q
lLa1
              "]]}, "Charting`Private`Tag#49"], 
           Annotation[{
             Hue[0.2373308974896915, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSrWAViBIQBMEiooRI
QsgRJDObD7PTzD7+zN+Z3f58PVt0lFIDpVSTOWpjz+clRQW+xk2U4DFFAd7v
mviZwDKn3PjCLzM9y2QXf40n/D6mK/ze6OeUop77X+At1T/BfN8D843I/w6d
U+L0R6gfUv0FzHoI3hCfMG/7gq1+ZF1LDsFT9tee0CPodj7oE54fvOL9wAfe
H5zw+zh+KXT7vtoX/h/U3/h/wHxfpuW+Ofrt/+tA+BWOX+n4VY5fjXn/oFS2
rw==
              "]]}, "Charting`Private`Tag#50"], 
           Annotation[{
             Hue[0.47339887498948485`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSbcAqECUgCIJFJBIi
EckRJPs3H3anmX38mb+zs/35erboCCEGQogmI2rl4RAtdfyU0aJL0sSXPNZR
kfe7Jj4qMIxUKt/yK1TPsLZL3rwPfrnqWn4v9iNlrEf/k7zV9Q9n/jvnG2n/
G3Wk1OmPyUNdf2Y/9JC80XzivO0GW/0IXdockqfwl56lx9TNfNQnmJ+8wvvI
B7yfnGI/jl9G3exX+pZ/zvor/oeM+wrHr2S/+X8ZWH6V4/d1/H7S3l9N/z+b
3Las
              "]]}, "Charting`Private`Tag#51"], 
           Annotation[{
             Hue[0.7094668524892711, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRdeYHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYSE
hJAjSPYnH3anmX38mb+zs6PVbrl2hBBjIUSbEY0a4BBsdNSq04J71EZFnuko
yadjG4XyOkbK1dDwy6hru+jH++CXsh5+X+Uafgnr0f8hH3T925r/xfmm2v9J
HSm2+kPyRNff2A/dJ+81Xzlvv8G+/wJdOgb75AX8pVkfUu/moz7H/OQt3kc+
4/3kGPux/BLq3X6la/inrH/gf8i4L7P8cmn+VyE9w6+0/Cpr/trya8h/lTS2
pQ==
              "]]}, "Charting`Private`Tag#52"], 
           Annotation[{
             Hue[0.9455348299890574, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRdeYHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYSE
hJAjSPYnH3anmf38mbezs6PVbrl2hBBjIUSbEY0a4BBsdNSq84J71EZFPdNR
Up+ObRTK6zRSroYGL6OvcdGP94GXsh68r3INXsJ69H+oD7r+bc3/4nxTzX/S
R4qt/pB6outv7IfvU++1vnLefoN9/wW+dAztUy/Al2Z9SL+bj/4c81Nv8T7q
M95PHWM/Fi+h3+1XugY/pf/A/1j3ZRYvl+Z/FdIzeCXrwassXm3xGuo/lDS2
ow==
              "]]}, "Charting`Private`Tag#53"], 
           Annotation[{
             Hue[0.18160280748885782`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAURNeEHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYSE
hJAjSHbWgd3f/Dxm/uzfzXC5Xaw8IcRICNF3VKcG+IjWulpltOiW9NWQp7pq
8vHQV6UCw2il8q28grqOS748D3k5/cj7kNEy+jH/Ju+1/+Xs/+R+E53/oI6W
OvMxeaz9V85DD8k7zRdnPyH+82fo0rM4JM+RL21/TN3sR32G/ckb3I98wv3J
Kd7Hycuom/eVvpWfU7/j/zjnFU5eKe3/VcnAyqvpR17j5LVOXkf+AZGktqE=

              "]]}, "Charting`Private`Tag#54"], 
           Annotation[{
             Hue[0.4176707849886441, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRdeEHMTSTtTCbu/gEQTFzqtYqljYeoRUCVgJUQKCIFhEIiGS
EHIEyf71w840s58/82Z2tz9fzxaeUmqglOoyoo16OMRLE01kvfiadFFTj01U
1PtdF98osBqpjHyHV9A3uOTDeeDlgvdmP1LGevS/qLem/in2f1CPDP9OjZSK
/gv10NSfuQ/8kP7G6JPYT6m/f4SvPUeH1FPwtVt/oW/3oz/B/tQr3I/6gPtT
p3gfwcvo2/fVvsPP6d/wP2JeIXgl++3/68DhVawHrxa8RvBa+j+MdLad
              "]]}, "Charting`Private`Tag#55"], 
           Annotation[{
             Hue[0.6537387624884303, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRdeEHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYRI
QsgRJPs3H3anmf38mbezs8PldrHyhBAjIUSXEa0a4BCtdTTKeNEt6aKmnuqo
qI+HLn4qMBqpVL7FK+hrXPLlfeDlDu/DfqSM9eh/U+91/cuZ/0k90fwHNVLq
9MfUY11/5TzwQ/o7rS/0+w32/hm+9CwdUs/Bl3Z9LG1eSn+G+ak3eB/1Ce+n
TrEfh5fRN/uVvsXP6d/xP859hcMr2W/+XwYWr2I9eLXDaxxeS/8Pixy2nA==

              "]]}, "Charting`Private`Tag#56"], 
           Annotation[{
             Hue[0.8898067399882166, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRdckF7G0E7Ww2zt4BEGx8yqWKha2HiHVBqwCUQKCIFhEIiGS
EHIEyf7Nh91pZj9/5s3s7nC5Xaw8IcRICNFlRKsGOERrHY0yXnRLuqippzoq
6uOhi58KjEYqlW/xCvoal3w5D7zc4X3Yj5SxHv1v6r2ufzn7P6knmv+gRkqd
/ph6rOuv3Ad+SH+n9YV+/4K9f4YvPUuHsvfn4Eu7PpY2L6U/w/7SjIk2uB/9
E+5PneJ9HF5G37yv9C1+Tv+O/6HGvMLhlew3/y8Di1c5vNrhNQ6vpf8HhBy2
lg==
              "]]}, "Charting`Private`Tag#57"], 
           Annotation[{
             Hue[0.12587471748801704`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhVeTi1jaiVrY7R08gqDYeRVLFQtbj5BqA1ZClIAgCBaRSIgk
hBxBsi95sDPN5PHtfNmfwWIzX/aVUkOlVNNRtenhI1zZqkzLwlvUVEk+sVWQ
H/ZN/YzfZrTceI4vI7e66Ct8qfB9OI+WcD3m38w7u/4l9v9kHlv/gxktNsqZ
v5KP7PoL9wMekG9tPpN3N9jxE7h2c8A8g1/wq3Z9se72N8X+mdc4H+ePOD9z
jPsRvoS8vV/tOf6U/I73Ycb/MuHLOd++v/YdXyF8pfBVwleT/wF97LaS
              "]]}, "Charting`Private`Tag#58"], 
           Annotation[{
             Hue[0.3619426949878033, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhqP1Io5uog5uuYNHEBQ3r+Ko4uDqETql4FSoUhAEwaFSKZWW
0iNI86c/9L3l9edLvr4kw+V2seorpUZKqaajatPDR7C2VRnHglvUVEk+tVWQ
Hw9N/YznMlpODl9mBi5bXfQVvlT4PsKXcD32v5n3dv1LzP9knlj/gxktNqqz
PyQf2/VXzgPuk+9svpC3N9jyM7juZp95Dr/goe76Yt3ON8P8zBucj/tPOD9z
jPsRvoTc3a/2Ov6U/I73Ycb/MuHLtXh/4SuErxS+Svhq8j94zLaO
              "]]}, "Charting`Private`Tag#59"], 
           Annotation[{
             Hue[0.5980106724875895, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAUhqP1Io5uog5uuYNHEBQ3r+Ko4uDqETql4FSoUhAEwaFSKZWW
0iNI86c/9L0l/fjzvr4kw+V2seorpUZKqWZF1aaHj2BtqyLfoqZK8tRWYVxv
cDw09TOeYyw5c/gyM3BsddFX+FLh+whfwv3ofxs3eLC3+19i/id5Yv0PMpZY
9IfMx3b/lYzcJ+8sXzhve4Ntfkauu+yT5/CLPNRdX6zb+WaYn7zB+dh/wvnJ
Me5H+BLm7n611/GnzO94HzL+lwlfrsX7C18hfKXwVcJXM/8DcwS2iw==
              "]]}, "Charting`Private`Tag#60"], 
           Annotation[{
             Hue[0.8340786499873758, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRUdzEks7UQu7vYNHEBQ7r2KpYmHrEVJtwCqgEhAEwSISCZGE
kCNI9icfMtNMPn/m5e/uYLGZL/siMhSRuqMq28NHsHJVUt+udRXUE1e5bXaD
w76un/UajZbRBy+l73DXr+IlivehRos5j/23bYIHOzf/Uvmf1GPHf1CjRWo/
pD9y8xdq+D711umzyifS+if4pqt96hn4yg9NlxeZNt8U+anXOB/3jzg/dYT7
UbyYfnO/9MFPyL/jfTiP/6WKlxn1/sbr8HLug1coXql4Ff0/bcS2hw==
              "]]}, "Charting`Private`Tag#61"], 
           Annotation[{
             Hue[0.07014662748717626, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRUdzEks7UQu7vYNHEBQ7r2KpYmHrEVIlYBWIEhAEwSISCZGE
kCNI9q8fMtNMPv/Py+zuYLGZL/siMhSRtqOaoIePcGWrpr7GbVXUE1tl4GbD
w76tb+A5jVbQBy+nb3HxR/EyxXtTo6XMY/4VuMXDnc0/1f4P6rHl36nREjUf
0R/Z/IUavk+9tfqs9hP5+yf4pqt96hn4Rjp+ZLq8hP4U+1OvcT7yjjg//QT3
o3gp8+5+6YOfcf6G92Ee/8sVrzDq/Y3X4ZWcB69SvFrxGvo/a+S2hQ==
              "]]}, "Charting`Private`Tag#62"], 
           Annotation[{
             Hue[0.3062146049869625, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdUTEKwkAQXM1LLO1ELezuDz5BUOz8iqWKha1PSHUBq4BKQBAECyUSIgkh
T5DcxIHbbfaGmZ2b2+vNVtN5V0T6ItJ0VG07OEQLVxXx5dxUSTxyVdh2Ntpt
m/raoMVoOXn4ZeSd3fljxfNLld+bGO3F+zH/5PzG6R8q/5146PxvxGiJmo+J
B05/oh58SLx2+Kjyifz5A3jj45B4An8jHh8blY/8GPmJl3gf9Xu8n3yC/Ri1
P+rb/ZKHf8r5K/6HetyXqXy5Uf9vAs+voB5+pfKrVL6a/j9m1LaB
              "]]}, "Charting`Private`Tag#63"], 
           Annotation[{
             Hue[0.5422825824867488, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwlAQRFdvYmknamH37+ARBMXOq1iqWNh6hFQJWAWiBARBsFAiISEh
5AiSnTiQ3WYzzOz7+38Gi8182ReRoYg0HVX7PXwEK62K+ho1VVJPtAq/nQ0O
+6ZyarTM8FL6iou+vnR4ieF9DO9NHuZfnN9p/mnOe1CPlX+nRovNfEg90vyF
efge9Vb12ewn8vdP8F1Xe9Qz8J10/NCZ/ehPsT/1Gvdj/oj704/xPs68H/Pt
+9IHP+H8Df+HeZyXmv0yw8sNr6APXml4ldmvJv8HX4y2fA==
              "]]}, "Charting`Private`Tag#64"], 
           Annotation[{
             Hue[0.778350559986535, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwlAQRFdvYmknamH37+ARBMXOq1iqWNh6hFQJWAWiBARBsFAiISEh
5AiSnTiQ3WYzzOz7+38Gi8182ReRoYg0HVX7PXwEK62K+ho1VVJPtAq/nQ0O
+6ZyarTM8FL6iou+vnR4ieF9DO9NHuZfnN9p/mnOe1CPlX+nRovNfEg90vyF
efge9Vb12ewn8vdP8F1Xe9Qz8J10/NCZ/ehPsT/1Gvdj/oj704/xPs68H/Pt
+9IHP+H8Df+HeZyXmv0yw8sNrzC80uxfmf1q8n9fLLZ6
              "]]}, "Charting`Private`Tag#65"], 
           Annotation[{
             Hue[0.014418537486335481`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRcfcxNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsIhEQkJC
yBEk++OHnWkmn//n7exmuNwuVp6IjESk66g2GOAjXNtqqG9xVzX11FYV9LPh
8dBVSR+tULyceYuLv4E4vEzxPtRoKXmYf3N+b/Mvdd6TemL5D+bREjUfUY9t
/sp5+D71zuqL2k/k75/hG1f71HPwjTh+ZNz3S+jPsD/1Bvdj/oT700/wPoqX
UvfvazyHn3H+jv/DPM7LFa9QvJIavErxarV/o3gt/R9aHLZ0
              "]]}, "Charting`Private`Tag#66"], 
           Annotation[{
             Hue[0.25048651498612173`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRUdvYmknamG3d/AIgmLnVSxVLGw9QqoErAJRAoIgWCREQkJC
yBEk++OHnWlmP3/mzezuaLVbrociMhaRLiNavz8EGxuNP+j1Peqipp7ZqKhP
xy5KaqSCGrzc72cFFhd9OQ+8jD54KTVSQh76P+w/2Pq3mveinlr+k/VIseoP
qSe2/sZ++B79vdVXtZ/Iv/4C37jao16Ab8TxQ+O+X0x/jv2pt7gf68+4P/0Y
76N4iXH/KzVDh5+x/4H/YT3m5YpXKF5JDV6leLXav1G8lv4PU9S2cQ==
              "]]}, "Charting`Private`Tag#67"], 
           Annotation[{
             Hue[0.486554492485908, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRTfexNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsEiIhISE
kCNI5ocPO9PMfv7Mm9nd8Xq/2oyMMRNjTJ8RXTAcwq1EG3iDfsR9NNRziZr6
fOqjokYqqcErgmFWKLj4x3ng5fTBy6iRUvLQ/2X/Ueo/at6beib8F+uREtUf
UU+l/s5++D79g+ib2o8RXuFbz9E+9RJ869ZH1n2/hP4C+1PvcD/WX3B/+gne
R/FS6/5XZkcOP2f/E//DeswrFK9UvIoavFrxGrV/q3gd/T9SjLZw
              "]]}, "Charting`Private`Tag#68"], 
           Annotation[{
             Hue[0.7226224699856942, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRTfexNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsEiIhISE
kCNI5ocPO9NMHjPzZjc7Xu9Xm5ExZmKM6TOiC4aPcCvRBt7Aj7iPhjyXqMnn
Ux8VGakkw1cEw65QdPGP++DLWYcvIyOl9GH+y/mj9H/Uvjd5Jv4X+5ESNR+R
p9J/5zzqPusH4Zu6LyO8om49h33yEn7r9kfW9SWsL3B+8g73I19wf3KC/6N8
qXXfK7Mjx59z/on3YT/2FcpXKl9Fhq9Wvkadv1W+jvU/UFy2bg==
              "]]}, "Charting`Private`Tag#69"], 
           Annotation[{
             Hue[0.9586904474854947, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRTfexNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsEiIhISE
kCNI5ocPO9NMHjPzZjc7Xu9Xm5ExZmKM6TOiC4aPcCvRBt7Aj7iPhjyXqMnn
Ux8VGakkw1cEw65QdPGP++DLWYcvIyOl9GH+y/mj9H/Uvjd5Jv4X+5ESNR+R
p9J/5zzqPusH4Zu6LyO8om49h33yEn7r9kfW9SWsL3B+8g73I19wf3KC/6N8
qXXfK7Mjx59z/on3YT/2FcpXKl9Fhq9Wvkadv1W+jvU/UFy2bg==
              "]]}, "Charting`Private`Tag#70"], 
           Annotation[{
             Hue[0.19475842498528095`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRTe5iaWdqIXd3sEjCIqdV7FUsbD1CKkSsApECQiCYJEQCYaE
kCNI5ocPO9NMHjPzZjc7Wu2Wa98YMzbG9BnRhcNHtJFoQ2/ge9JHQ55J1OTT
sY+KjPQjw1eSRZd8uQ++IvQdX05GytT8h/MH6X+rfS/yVPxP9iOlaj4mT6T/
xnnUA9b3wld1X0Z0Qd16DgfkBfzW7Y+t60tZn+P85C3uRz7j/uQU/0f5Muu+
V259x19w/oH3YT/2lawP76t8FRm+Wvkadf5Wna+j/w9NzLZs
              "]]}, "Charting`Private`Tag#71"], 
           Annotation[{
             Hue[0.4308264024850672, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRSe5iaWdqIXd3sEjCIqdV7FUsbD1CKkSsArEsCAIgkUkEgwJ
IUeQnQkfdqbZ/fw/b2d3R6vdch0S0ZiI3CrVx8Mm2XB10PfMVRsHg55xNdCn
o6saeVl+8IVXQTMu+yIvvFLxPnHo8QrV/0b/gfMvdd4Tesr8h5rPqv4UesL5
G/rFj+DvWV/hk1/JRXwTeDqCXgjf+PnU+DwLfy7zQ2/lftBnuT+0lfdRvMKo
9zWhxy/Rn8v/IC/nVfCH/1W8Ws3bKF6r5u/UfD34f0a8tmg=
              "]]}, "Charting`Private`Tag#72"], 
           Annotation[{
             Hue[0.6668943799848535, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAYhdPexNFN1MEtd/AIguLmVRxVHFw9QqcUnApVCoIgOFQqxdJS
egOleeFB/rekj/fy9U8yWGzmy1ApNVRK9SvUGfcRr6xa+mvaqzGB8xOrmv6w
71Wxj+XLHLyS3uLSD/vgFYL3NqHHy8X+l/lBZmf7TzH/g/2x5d/FfBk99if0
I9u/cD/yiPnW+jNz5Ss+IdeB5yP6Gfja7yfa52XMp5iffo3z0R9xfvoM9yN4
uRb3q0OPX3D/De/DPv5XMnfvK3iVmLcWvEbM34r5OvL/ChO9Xw==
              "]]}, "Charting`Private`Tag#73"], 
           Annotation[{
             Hue[0.9029623574846397, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAYhdPexNFN1MEtd/AIguLmVRxVHFw9QqcUnApVCoIgOFQqpdJS
egOleeFB/rekr+/l6590sNjMl6FSaqiU6leoM+4hXlm19Ne0V2MC5ydWNf1h
3+vLPpaKOXglvcWlH/bBKwTvbUKPl7OP/S/zg8zO9p9i/gd5Y8u/s4/XGfvY
n9CPbP8i8oh+a/2ZfOUrPiHXgecj+hn42u8n2udlzKeYn36N89EfcX76DPcj
eDlzd7869PgF8xv+D/fje6X276/S4v+LeWvBa8T8rZivY/4HPJXLTA==
              "]]}, "Charting`Private`Tag#74"], 
           Annotation[{
             Hue[0.13903033498444017`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAYhdPexNFN1MEtd/AIguLmVRxVHFw9QqcUnAq1FARBcFAqpdJS
egOleeFB/rekX/+Xlz9/BovNfBkqpYZKqX6FOuM+4pVVS76mvRoTOJ5Y1eTD
vteXfiwV68gryTYu/dCPvELkvU3o5b3ox/6n+UFmZ/0P0f+deWObf6Mfv3P6
sT8hj6z/IuoReWv5zHzlKz6hrgOPI/IM+dr3J9rPy1mfon/yGvcjH3F/co75
kN38yG6+OvTyC9YzvA/7wXml9udXafH+ot9a5DWi/1bct2O/fzvdy0s=
              "]]}, "Charting`Private`Tag#75"], 
           Annotation[{
             Hue[0.3750983124842264, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRdfcxNJO1MJu7+ARBMXOq1iqWNh6hFQbsApECQiCYKFEQkJC
yAmM7Mz6Yec3m7/z9+3spD9fzxaBUmqglLIrqzXuI1qSGvhLYlWbnvNjUgW/
31mVyPNSCF6OPOGSD+rMywTvbQKP90Kezz/NtyOZLeUf4r47eCPi30zn8ryd
Is/nY/gh5c+iHsJvyJ/AV76iI9e170P9z0+ZL+qx9nkp6hPuH37F74M/8Pvh
U54PvJsfvJuvDjx+hvqV/4+4L9f+/ArBK0W/leDVgteI/lr4HzWty0U=
              "]]}, "Charting`Private`Tag#76"], 
           Annotation[{
             Hue[0.6111662899840127, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRdfcxNJO1MJu7+ARBMXOq1iqWNh6hFQrWAWiBARBsFAiISEh
5AQq2b9+2Jlm+fl/385MutPlZBYopXpKqfZENeaLMnNbtXHG8Ry3VZmO00Nb
JfV201bBPI6cGryMeYuL3/TBSwXvZQKP92Qe9x/m4/pd2/xdvHcjb2D5V86H
zwnzuB9R923+JPyQemX1gXzl13EPX/s61P/8GHzhR9rnJfRH6J96gfn0f54d
5qefYD/Ubn/Ubr868Pgp/Qv+j3gv0/7+csEr6INXCl4leLXor6H+AXM44C0=

              "]]}, "Charting`Private`Tag#77"], 
           Annotation[{
             Hue[0.8472342674837989, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdUTsKwkAUXL2JpZ2ohd3ewSMIip1XsVSxsPUIqTZgFYgSEATBQokEQ0LI
CVSysxnYN80yO+/N+/Vmq+m8q5TqK6WaF6jNDzALi8o4ITzHDUrTcXxkUVDf
bRvkzMf3hzr8MuZbu/hNHX4pdfi9jOstxPNkPPIf5uvqbWz8XdS7kQ+t/1X0
l1BHfkQ+sPEnoQfka8uP7Ff5CA/Qtc8D3cZP4C/0SPt+CfUx+idfYj7dzrPH
/NQT7Ifc7Y/c7Vd3Pf+U+gX3EfUyLe4r/HLd3gN+hfArhV8l+qvJ/0Cs5yI=

              "]]}, "Charting`Private`Tag#78"], 
           Annotation[{
             Hue[0.0833022449835994, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdUTsKwkAUXHMTSztRC7u9g0cQFDuvYqliYesRUm3AKhAlIAiChaKESELI
CVSysxnYN80yb96b99nudDmZBUqpnlKqeYHa/AAzt6iME6JT0qAkH1oU5NtN
g4/5unqEc+rwy0zHcWuXvIXfizr8nsbNFuF5MB/1d/Zb2/yb6HclH1j/C/dD
OKWO+pi8b/OPQg/JV5YfOK/yEe2ha5+Hus0fw1/osfb9UuojzE++wH663WeH
/amnuA+5ux+5u68OPP8X9TP+R/TLtH+/XPh9dPsf8CuEXyn8KjFfTf4HO/zn
IA==
              "]]}, "Charting`Private`Tag#79"], 
           Annotation[{
             Hue[0.31937022248338565`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAYhVNv4ugm6uCWO3gEQXHzKo4qDq4ewSkFp0KVgiAIDkqltLSU
nkClefFB/reEL+/PS/4/3elyMusopXpKqXaFGvOFzNyqNs4Iz3Grijy0Ksnb
TavCfNx5bOf0kZeZwLGNi98iL6WPvJdxbwuxPFmP8w/et7b1d3HfjTyw+Vf2
h+2EPs5H5L6tPwn/SF5ZPpCVr3APX/t8JI+RL/xIB15eQn+E95MX6E//+9mh
f3KC+bDezY/s5qs7Xn5K/4L/Efdl2p9fLvIK/f8P5JUirxJ5tXhfQ/4BlqPu
Fg==
              "]]}, "Charting`Private`Tag#80"], 
           Annotation[{
             Hue[0.5554381999831719, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb0KwjAUhdO+iaObqINb3sFHEBQ3X8VRxcHVR3BKwalQpSAIgoOiFIul
9AX8oTnpgdyzhC/n3pObpDWaDcehUqqtlKpXqDI/yEysSuOM6JDUKsg9qzd5
tayVm4/rx/aLPvIyso1LniLvYQIv727cbBGWm+i/mq87b2HrL+K8M7lr80+8
H7ZT+uiPyR1bvxf+jjy3vCUrX9EGvvZ5Rx4gXzfzwI914OWlrO9jfvIU92P/
Gvcnp3gf1rv3I7v31aGX/6B/xP+I8zL99f9X5OW6+X/kvUVeIfJKMV9F/gMc
V/UK
              "]]}, "Charting`Private`Tag#81"], 
           Annotation[{
             Hue[0.7915061774829582, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwjAYhaM3cXQTdXDLHTyCoLh5FUcVB1eP0CkFp4JKQRAEB0UplpbS
C1ileemD/G8JX17+lz/5O5PFeNpWSnWVUvUKleYHmZlVYZwRno61cvLAKiNv
1rVS83X12P7QR15CtnHHt8h7mZaX9zSutxDLQ9TfTeXuW9nzN3Hfldy3+Re+
D9sxfdRH5J49fxB+QF5a3pOVr3AHX/sckEfI100/8CPt58XkIfrn+TneR97i
/eQY/yPyHmT3v7rt5b/onzEfMu5LdOXPV+Slupk/8jKRl4u8QvRXkv9XhfwB

              "]]}, "Charting`Private`Tag#82"], 
           Annotation[{
             Hue[0.027574154982758614`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkU0KwjAQhWNv4tKdqAt3uYNHEBR3XsWligu3HqGrFFwVqgQEQXBRqRSl
pfQC/tC89EEym/DlzbyZZLrT5WQWCCF6QojmRNTqh1BzE5WyQnRKmijJQxMF
ebtp4q0+th7XL+rwy8nGLnl6fpnqOH4PZWeLcKScD/V39bW8Nvk3r9+VPDD+
F9bjWlNHfUy9b/KPnh6SV4YPZOFGtIcuXQ7JY/jLth/0WLp+mjzC/Mxf4H2y
ff8O76eu8T+eX0rd/q8MHP+M+Wfsh4x+OfvZ/VK3+5ft/uFXeH6l51d589Xk
P6DlEPc=
              "]]}, "Charting`Private`Tag#83"], 
           Annotation[{
             Hue[0.26364213248254487`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAViCAiCYBGJBENC
yAH8I/s2D3Zfs3w7M29mdnuz1XTeFUL0hRDNCdXqB6mFVqVMwD+HjUrySKsg
77aNcvUx9bh+OX4Z87Vd+HT8UtWx/B7KzObjSOiH+rv6Gt7o/Bv90O9KHmr/
C+txHZNRH5AHOv/EesQ98lrzkSxs+QfEpc0eeQJ/2fZDPJC2X8z4GPOTl9hP
tvvvsT/jMd7H8UsYN+8r2/eFf8r8CP9DRr+M/cz/On65fFvzFo5f6fhVznw1
+Q8GKSzW
              "]]}, "Charting`Private`Tag#84"], 
           Annotation[{
             Hue[0.4997101099823311, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkj8KwjAYxaM3cXQTdXDLHTyCoLh5FUcVB1eP0CkFp0KVgiAIDpVKsbQU
D1BUmpc8SN4Sfnn5Xr786c1W03lXCNEXQrQj9FE/SC20amWM8By3qsgjrZK8
27YqVGPqMf328nKyjotfXl7m5T1VxzCG1Kt/qK/hjV5/Zz32u5GHOv/Kekwn
ZNRH5IFef2I9/IC81nwkC1fhAb50OSBPkC9t//Aj6eYl0vYzRv/kJc7H+j3O
Tz/B/Xh5KX1zv9LeL/Izrr/gfcjYL+d+5n29vEI2Tr8lfeRVXl5N3/w/9vsH
9LVBuQ==
              "]]}, "Charting`Private`Tag#85"], 
           Annotation[{
             Hue[0.7357780874821174, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkj8KwjAYxaM3cXQTdXDLHTyCoLh5FUcVB1eP0CkFp0KVgiAIDpVKUVqK
B6h/SF76IHlLeXn5ft+XpJ3JYjxtCyG6Qgj9hd7qB6mZUaVsEB5jrZJ+YFTQ
b9ZaL1Xbeiw/1dfh5eQbXPygBy/zeHfVsh6f1Ku/kb8y+6+sR78Lfd/wz6zH
ckKP+oi+Z/YfvDygXxq/J1+4CnfIpesD+hH4spkfeSRdXiKbfkPMTz/H+Vi/
xfmZJ7gfj5cyt/crm/sFP+P+E96HHv1y+XHfl/3t+8vambdgP/BKj1cxt/8f
5/0DVV5Wng==
              "]]}, "Charting`Private`Tag#86"], 
           Annotation[{
             Hue[0.9718460649819178, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkjsKwkAQhldvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgpIQ
PEB8sPtvftidZvkyM9/sI53JYjxtCyG6Qgi9It7qh1AzE5WyifAY6yjJAxMF
6zdrHS9VW0bZU30dX856o4sfZPgy+uG7q5ZlLKnXf6N/Zeqv7Me8C7lv/Gf2
43NCRn9E7pn6g5cPyEvDe/qFG+EOeelyQB7BL5v9Ix9J15fIZt4Q+yfPcT72
b3F+5hPcj+dLmbf3K5v7hT9j/Qnv483L5cd9X8637y9rZ78F++ErPV9Ftv8f
+Q/q+nJ+
              "]]}, "Charting`Private`Tag#87"], 
           Annotation[{
             Hue[0.2079140424817041, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgiEh
pPeX7Ns82H3N8u3MvJnZ7UwW42lbCNEVQtQnVKkfpGZaJfkY1iqUSfQHWjnj
m3WtTL0NI+2pvpZfStZ24YP18EvoD7+7ahnGETv1N/JK519Zj34Xcl/7n9kP
1xEZ9QG5p/MPTtwjLzXv6S9s+TvEpc0eeQR/2cyPeCCd+chDzE+eYz/5MbzF
/oxHeB9pzxezn3lf2bwv/BPWn/A/Tr+U/cz/On6ZfFnz5o5f4fiVzr4V+Q+/
2odh
              "]]}, "Charting`Private`Tag#88"], 
           Annotation[{
             Hue[0.44398201998149034`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgpIQ
0sc/sm/zYPc1y9uZ+WZmtzNZjKdtIURXCFGfUKl+kJppFfTHsFauTKI/0MoY
36xrvVRlPNKe6mPxUvU1XuPCB+vBS8gH765axuOInfob+Sudf3Xmv5DX1/wz
47iO6FEf0Pd0/sGJe/RL7ffkC1v+DnFpe49+BL5s9kE8kM589EPMTz/HfrLZ
f4v9GY/wPtKeL2Y/876yeV/wE9af8D9Ov1S+7f9lf/P/srLmzRxe7vAKZ9+S
/g8OYY5U
              "]]}, "Charting`Private`Tag#89"], 
           Annotation[{
             Hue[0.6800499974812766, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgpIQ
0sc/sm/zYPc1y8fMvPnZzmQxnraFEF0hRP1CpfpBaqZVkI9hrVyZRH+glTG+
Wdd6qcow0p7qY/mlZG0XPlgPv4T+8LurlmE8sfpa9Tf6rXT+1Zn/Qu5r/zMZ
fhEZ9QG5p/MPTtwjLzXvOa+w5e8QlzZ75BH8ZbMP4oF05iMPMT95jv1ks/8W
+zMe4T7Sni9mP3Nf2dwX/gnrT/gfp18q3/b/sr/5f1lZ82aOX+74Fc6+JfkP
8jqVSw==
              "]]}, "Charting`Private`Tag#90"], 
           Annotation[{
             Hue[0.916117974981077, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb0KwjAUhaNv4ugm6uCWd/ARBMXNV3FUcXD1EZwiOBWqFARBcKhUSqWl
dG/9oTnJgfQu4eOee3Ju0pksxtO2EKIrhKhPVKF+KDXTlZPPfl2ZMsLjQFfK
/mZd11uVhiFLVOX4xepjWNv5L87DL6I//J6qZRhHqL7O/IN+K62/s4/7bvTv
a/8rGX4BGfMe53tafyKjfyAvNe+Z176g9duhL20ffCCP4C+/jt6TjXzkIfJT
P8d+0u6/xf7UB3gf6eYLOW/eV9r3hX/E+Qv+h4z7Ylk5+RKy+X9ZOnnThl/W
yJ839i3If8HNnDs=
              "]]}, "Charting`Private`Tag#91"], 
           Annotation[{
             Hue[0.1521859524808633, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdUbsKAjEQjP6JpZ2ohd3+g58gKHb+iqWKha2fYBXB6kBFEATBQjk5FI/D
2tfJZZKBZJswzOzs7KbSGbS7ZaVUVSlVvKin/uWmdM9UpnOLN+uiUm2Fy4ap
B/nJuKi7flsM2U1/PL+E2Nitr+yHXxz4XXTJzsNzZj70n/TX4pHRH4P8B/rV
jf+ePPx25NEfka8Z/YoY/IJ4aPCc93AXdH4z8OJ44IU4vgV/+Xn6iLzNR9xE
fur72E/c/lPsT/0O9xE/35n99r7i7gv/mPwW/0M/zEsk+F/5eH53eXl5H4Ff
GuTPgn2fxH/IB6ok
              "]]}, "Charting`Private`Tag#92"], 
           Annotation[{
             Hue[0.38825392998064956`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamE3d/AIgmLnVSxVLGw9QqoVrAIqAUEQLBRFFEVS
x5hI9u0+2EyzPN7sN3+13qjbryql6kqp4kXEOstN6IGJj86t3m6KeGubuGqZ
eDF/Ni3iqROrkfbQqce7Uxvc5kY+eFdq8C66YuvhObMe/p/0z+qJyT+W+j+Q
1zT8PX3wImr8D6kbJn9d8gPqsdFL7sNt0NVbwBfnQwfi/A74knn5IX3bH/02
+qceYj5x888xP/9H2I/4/Z3Fv9dF3H7Bv9Lf4T7kod5dvv59JfV4T0m8fl8l
3pv9gvcpzRtT/wHAr6of
              "]]}, "Charting`Private`Tag#93"], 
           Annotation[{
             Hue[0.6243219074804358, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KAjEQhQdvYmknamE3d/AIgmLnVSxVLGw9glUEqwUVQRAEC5cVURSx
9mdXNi/7IJkmPF7yzZtMud1vdUoiUhGR/ES9TJrZMl1bT5M5vV7l9aCu27rz
/niU1828nQbvar4e70JtcatzwEuowYsdRxY4TuyH90fzc3po7x+C/Hvyapa/
ow/elhrvI+qqvb8M/Dn1wOpZkE+k6DeFr76eUzfB19TzI/ouH/0G8lP3MJ8W
808wP/0t/keD/1N/XzF98BP6G+yHedDvoh9/v/r1eDd9e3nvAe/BvOA91d/H
i/P/AdfuuAs=
              "]]}, "Charting`Private`Tag#94"], 
           Annotation[{
             Hue[0.8603898849802363, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KAjEQhQdvYmknamGXO3gEQbHzKpYqFrYewSqClaAiCIJgscvKoiiy
taw/7Lzsg2Sa8HiZL28y1e6w06uISE1EihOV2e9Py/a1XtS7bVFP+3O6qfWg
P50Udbdvp8G72dzjpdSK217ZD15CPnix48gKR8T76L/Yj9NjvX8O8p/Iayj/
SB+8AzX6N9R1vb8O/CX1SPUiyCdSvjeHb3y9pG6Db76ev6Hv8tFvIT/1APOZ
cv4Z5qd/wP8EvMj4+4pNmR/8hP4e+2E/3ktNsF+Te7w7ffAeAe/JvOC9jL+P
jHn/wJ2/AA==
              "]]}, "Charting`Private`Tag#95"], 
           Annotation[{
             Hue[0.09645786248002253, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KAjEQhQdvYmknamE3d/AIgmLnVSxVLGw9glUEK0FlQRAEC2VlURSx
9F/ZvOyDZJrweJkvbzL5ervWyIlIQUTSE3Uz358t07R1pV7M07qYn9NlW2f6
/V5aJ/NwGryjeXu8xLyctrj5gf3gxeSDt3ccmeDY8T76t+bjdNfe3wT51+SV
LH9FH7yIGv0z6qK9Pw38MXXH6lGQTyR7bwhffT2mroKvX8+f0Xf56FeQn7qF
+TSbf4D5qSP8T8Dbqb+vvWb5wY/pL7Ef9uO9RJ/+fvXt8U569/KeA96F+cC7
qr+PG/P+AbrVvvs=
              "]]}, "Charting`Private`Tag#96"], 
           Annotation[{
             Hue[0.3325258399798088, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KAkEMhYM3sbQTtbDLHTyCoNh5FUsVC1uPsNUIVoKKIAiChaKIsotY
Lv6z82YfzKQZHkm+vEyKzW6jVRCRkohkL+Jhvj8bpm3jTr1cZJGYn9NVGzHz
w0EWN5M6Dd7VvD3exbyctrjFmf3gncgH7+g4MsVzYD369+bjdN/W7wL/W/Iq
lr9hHrw1Nfrn1GVbPwvyEXXP6kngTySfN0ZefR1p3l8HXz9efq6BP+oa/LO+
g/00/98R9md+jf/hfPd/6t/rqLl/8E/sX+E+rMe8iz79+3K+u7+mnt+Y/eAl
gf97sO+Dfv+yhb7z
              "]]}, "Charting`Private`Tag#97"], 
           Annotation[{
             Hue[0.568593817479595, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uB27+AjCIqbr+Ko4uDqI3SK4FRQKQiC4KBUiqWl
dCzWWmku+SG5JXzc3ZfLpT2ejyYtIURHCNGcHLn81SrkVEUGPh2bSMF9FYms
NK9XTcSy0My+tywtXwRWuuPL8YWytnxP7RF7Ph6o5/477l+q+psz/xW+nvJf
kGdfAOZ+H9xV9Qcn74EXinfwmw0a3nKebPbI9A/ZT5WV98mZDzzg+VE/4/fR
V/OG3498wPvB/Xp/8On9ktkv+0P0n/l/UM/3RfSx/5dKyxdTYc2boJ99qTN/
5rw3x7x/9BjF5w==
              "]]}, "Charting`Private`Tag#98"], 
           Annotation[{
             Hue[0.8046617949793813, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTsKAjEURYM7sbQTtbB7e3AJgmLnVixVLGxdglUEK0FlQBAEC0WRGWYQ
Sxm/TG5yIXlNOLzkvE/K7X6rU1JKVZRSxYl46O/PhO6auJM36yIyct1Eqj+W
x6MiEv20DF+sX57vpnPLRre+Br6L/nm+s/WoBY4T6+H9kTw09w9k1NvTVzP+
HevBF5HxfkWumvvLwD8nDwzP6HcbdDxFXnyei/M34ZePl19J0B+5gf55v4f5
5G15gvmZj7Af1rf7E/+/zuL2C/+F+S3+h/VR7ya554vl5fkSeXr9pnwPXxb0
fw/mfbDfP+q4xeE=
              "]]}, "Charting`Private`Tag#99"], 
           Annotation[{
             Hue[0.04072977247918175, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KAjEQRoM3sbQTtbCbO3gEQbHzKpYqFrYewSqClaCyIAiChcvK4qKI
pf/K5ks+SKYJj8m8mUyKzW6jVVBKlZRS+Ym46e/PhG6buJJXyzwu5KqJs/5Y
Hg7yyPTdMnwn/fJ8qX5aNrrlMfAl+uf5YutRMxwH9kP9ntw393dk9NvSVzH+
DfvBF5FRv2B92dyfB/4puWd4Qr/boOMx8uLzVFy/Ovzy8fILCeYj1zA/73fw
PnlbHuH9zEfYT+A7iP9fsbj9wp8wv8b/sB79Unn4/ysvz5fJ3Zv3zHr4LsH8
12C+G/f1B+gQxd4=
              "]]}, "Charting`Private`Tag#100"], 
           Annotation[{
             Hue[0.276797749978968, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkc8KQUEUh0/exNJOWNidd/AIiuy8iiWysPUIVqOsFLqllLIgEpHs/Hd1
5zf3VzNnM32dc75zZiZbbVZqGRHJiUhyIm7mF9swdRtX8myaxMV8HRdtnMnd
ThIn83AM39G8Pd/BvBxb3XRPP3w7Mnxb55ERjg3noX9Nbtv6FRnzlvQVrH9B
hi8io3/C/rytHwf+IblleWBizyeS+vrIa+zxUNN8GX79evmJBvuRS9if9Q3c
Tz+Oe7g/8xHeJ/Bt1P+vrabvC/+O+Tn+h/2Yd9Cn/7/69nwnvXv7ntkP3yXY
/xrsd+N7/QHgWMXZ
              "]]}, "Charting`Private`Tag#101"], 
           Annotation[{
             Hue[0.5128657274787543, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamG3d/AIgmLnVSxVLGw9gtUWVoKKIAiCRUIkRAwh
XQhRI9m/fphMEx5/581stjmcDkYNpVRLKVV9Uan5lrbM2FZCPh6qis3HcdfW
i7xcVPU0mWP4IlMIX2hyx1Z3eNAPX0CGzzel8Hmch/47eW7P38iYd6WvY/0X
5vCdmaN/z7xtz+9q/i15ZnlT20+pv2+NXJeCt/qf9+HXH5Hvmbv9yD3sz/MT
3E+/Ha9wf+Zn/J+az9PyvXzuB3/A/IT3YT/mhToXvkgXwvfUmfC92A9fzH3h
S2r7peQfjNbTxA==
              "]]}, "Charting`Private`Tag#102"], 
           Annotation[{
             Hue[0.7489337049785405, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamE3d/AIgmLnVSxVLGw9gtUWVoKKIAiCRUJEFEVS
BULUSPavHybThMfMvJnJVrvDTq9ijKkZY4ovIrbf3IXtu3iRt5sinvbjueni
QZ5OirjbxDN8N5sp39Wmnp1ucyn5Is6DL7S58gWsR//Zvj2PXf2JjHlH+hrO
f2A/fHsy+tfkuqtflfJL8sjxorSfMf95c+RF85Lchl8+Kr9m3u/HfAv7kwe4
T/73znA/83v8H9H3BqLfK5Rc+SPmd3gf7oN5V0mV7yaZ8t0lUb4H++F7cl/4
XqX9Yt7/A3/207o=
              "]]}, "Charting`Private`Tag#103"], 
           Annotation[{
             Hue[0.985001682478341, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uCWd/ARBMXNV3FUcXD1ETplcCpUKQiC4NBSKZWW
0qVDQa00f/tDckv4uLsvd0l/vp4tekKIgRCiORGF+tU61FJHrr4tX7wmMvVp
eawjZX6/a+KtypbhS1Rl+GKy1nkv9sMX8X74QlUbvoD16H9ynq2uf5Bx352+
kfbf2A+fT0a/Sx7q+rOVd8gbzSf6uxfs+Ii8NNmRXf8UfjLyrrTmI08wv+z2
W2E/8gH7s97H+1i+QJr/Fcra8EfMX/E/ZNwXy8rwJeT2/2Vp+FLuD19mzZ9b
8xWs/wNuftOt
              "]]}, "Charting`Private`Tag#104"], 
           Annotation[{
             Hue[0.2210696599780988, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KAjEQRoM3sbQTtbCbO3gEQbHzKpYqFrYewSqFlaAiCIJgscvKoiiy
xTbiz8rmSz5IpgmPmXkzSardYadXUUrVlFLlicj0rzCh+yae+mt5uynjoT+W
mybuzE8nZdx0bhm+q355vpRsdJsL++FLOB++WBeeL2I9+s/cZ2zqT2TMO7K+
YfwHMnx7MvrX7K+b+lWQXzI/Mrzgvu4FHc+RF5+X4nxt+MnIryXYj9zC/uLm
D3A/eVue4f7M7/E+gS8S/79iKTx/wvwO/0PGvFRenu9Ktv8vuee7B75HsP8z
2C/je/0BZW7TpQ==
              "]]}, "Charting`Private`Tag#105"], 
           Annotation[{
             Hue[0.45713763747789926`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrIQoAUEQLBIioiSI
RZrgTyT7Ng8204SPmfftbLY5nA5GDaVUSylVflEv/StM6bGpp/5a3vtlpfpj
uWsqYX+5KOuhM8vw3XXu+G5ko/OvzMMX83z4Il04vpDzyF/02/LczJ+5H847
cb5j/EcyfAEZ+R3zbTO/JaPvkWeGN9y3+oMVr9EXlz2p8n345ev0d1Lbj9zD
/sxPcD+p7r/C/dkP8H9qvlDc94qkcPwx8we8D+dx3k1yx3cn2/eXzPElzMOX
1vZ/1vZ7kf9gZtOg
              "]]}, "Charting`Private`Tag#106"], 
           Annotation[{
             Hue[0.6932056149776997, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uB27+AjCIqbr+Ko4uDqI3TK4CSoCIIgOCiVolhK
hy6itdL86Q/JLeHj7r5cLvX+uDeoKaUaSqnyRKT6V5jQQxOJzi3vtmXE+mu5
beJFns/KeOrMMnwP/XZ8EdnotnfPF/I++G66cHxX5tF/0R/LU1N/pg/3nVjf
Mv4jGb4DGf0b9jdN/ZqMfECeGF5xX9UGK14iLy4HUvV34ZfcyW/Em4/cwfzs
H+F9Ur1/gfczf8B+PN9VvP1K4fhD9u/xP6zHfZG8Hd+DbP9fMsf3Yj98sTd/
4s2Xkv9Z7tOd
              "]]}, "Charting`Private`Tag#107"], 
           Annotation[{
             Hue[0.9292735924774718, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamG3d/AIgmLnVSxVLGw9QqoprAQVQRAEC0UJCRGx
EBLwJ5J9mwe704SPt/PN7KbaHXZ6FaVUTSlVfFFP+eampG/qQd6si7rLx3LT
VEKeToqK5WUZvkhSxxdKZtno1jfPd+U8+C6SO74zc/Sf5G15bM4f6cO8A7lh
/HsyfDv60L9iXjfnl2TkAXlkeCE/x6dUyXPk+utwoMv+NvxeviLb/cgt7M/+
Ae6ny/vPcH/mO7yP5ztr73117viv7N/i/3jzQp05vkinji/WL8eXcB58d+4L
38Pb70n+A0p+05E=
              "]]}, "Charting`Private`Tag#108"], 
           Annotation[{
             Hue[0.16534156997727223`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLJRISEgI
gRQJaKJkZ/PB7jThMTtvftKdLiezjhCiJ4RovhyZrH4q5FxFCj55TSTyq3mo
IgZvN01EMtfMvlAWhi+QpWal896Wz0c/9r1kbfieyHP9Q340r9X7O3zc7wYe
KP8VzL4LmOtdcF+9P1p5B7xSfLDmE6LlPeepMtihtn7MfjDnXbLmA494fvCC
96N2/x3vj/yF74P++n5k3Zdqw++j/sz/x+oXUGn4QioMX0S54YstX4J52Zda
82XgP0B204g=
              "]]}, "Charting`Private`Tag#109"], 
           Annotation[{
             Hue[0.4014095474770727, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9gtUWVgEVQRAECyUiiiEE
AkFQo2S/zQe704TH7Lz5SbU77PQqSqmaUqr4IhL9/ZnQfROx/ljerIuIyE0T
T/J0UsRDp5bhu+vM8d30y7LRra+eL2R/+C46d3xn5lF/0m/LY/P+SB/6HcgN
49+T4duRUR+Q6+b9yssvySPDC28+pcr55siLy0sp69vwk5EPxJuP3ML8Uu47
wH7kGfYn73Af9rf3E+++kjv+kPVb/B/2R7+bvBzfXTLH95DU8T1ZD1/kzR97
8yXkPzfu04E=
              "]]}, "Charting`Private`Tag#110"], 
           Annotation[{
             Hue[0.6374775249768447, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb0KwjAURoNv4ugm6uCWd/ARBMXNV3FUcXD1ETrdwalQRRAEwaFSKZaW
UihU8adKc9MPkruEw809+ZI0h9PBqCGEaAkhqpUro89PFY1VpeCdV1VCb81d
VTH6y0VVEeWa2XenwvCF9NSsdN7N8gX0NXxXKg2fjz7PX+ilea72n638J3BH
+Y84j30HMM+74Lbav8U89x3wTPHGyidEnW/NfWmyI+v5PvvB3HfBOp+s8/Q4
P3jC9wOv+P7gA7+P5fOl9b6yNPwB5vf8P5jn80L5MP9XFoYvkrnhizHPvsTK
n1r5MvAfKA7TdQ==
              "]]}, "Charting`Private`Tag#111"], 
           Annotation[{
             Hue[0.8735455024766452, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamG3d/AIgmLnVSxVLGw9QqoprAJRBEEQLCKRkJAQ
QiAE/Cc7mw92pwmPmXk7M2mP56NJSwjREULUX46c3j8VNFWRgQ9eHSm9NPdV
JMivV3XEVGhmX0Sl4Qup0qx03sPyBfQxfHf6Gj4fee6/0VPzUtVfrfkv4J7y
n/Ee+05g7nfBXVW/Rz/nHfBC8Q7zNBdseMt5+TbYkY1/yH4r74L1fKgf8Pzg
Ge8nm/03vD/yJ76P5fOldV/5NfwB+o/8f9DP74WyMnyRLA1fLAvDl6Cffak1
f2bNl4P/HDbTbA==
              "]]}, "Charting`Private`Tag#112"], 
           Annotation[{
             Hue[0.10961347997641724`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamG3d/AIgmLnVSxVLGw9QqotrAJRBEEQLCKRYEgI
IRAFTVAys/mwO014zMzbv5v2eD6atIQQHSFE/eXKVPmjUlOqVH01H7y6EnCf
Ksb8elVXpHLN7HuqwvCF6q2ZdN7D8gWW764qw+ejz/s39dG8pPmrlf8C7pH/
jPPYdwLzvgvu0vwe+9x30F8Q76x8QjS85b4sDXZkk3fIfqvvgnU+2Zw34Pzg
Gd8Pvg3fH/0Tv4/l86X1vrIy/AH2j/x/MM/nhfJl/l9ZGL5I5oYvxj77EuRl
X2rly8B/D3bTYg==
              "]]}, "Charting`Private`Tag#113"], 
           Annotation[{
             Hue[0.3456814574762177, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uCWd/ARBMXNV3FUcXD1ETplcCpUEQRBcKhUiqWl
lEIVtEVpLv0hd0v4uLvvLkl7PB9NWkKIjhCiPikyVf50qKmOVH0NH7w6EnBf
R4z69aqOSOWGyfdUheUL1duw1nkP5guY764qy+cjT/039TG81PVX+GjeBfU9
7T8jT74TmPpdcFfX71neAS8079h+QjS8pbwsLXZks++Q/Czvgs1+spk3oP3R
P6P7gTd0f9Sf6H2Yz5fsfWVl+QP4jvQ/qKd5oXzZ/ysLyxfJ3PLF6CdfwvZP
2X4Z+A8KxtNe
              "]]}, "Charting`Private`Tag#114"], 
           Annotation[{
             Hue[0.5817494349760182, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAUhBdvYmknamG3d/AIgmLnVSxVLGw9QqotrAIqAUEQLCKRYEgI
IQQFf1CykwzsTrMM89733u42h9PBqCGEaAkhyhPK1OenpcZaqXpXfr8rldB3
tWLWLxelIpVXHry7KgxeqJ6V17jdTb0MXmDxrvTg+ZyP/gv757r+zBzzTuzv
aP6ROXgePfpd+rau31q5Qz/TfqO+Bk+Iet4auTS9I+t9++BbuSvN+3qyntfD
/uyf4H70K9yf9R7ex+L5zKv3ZQ5+QN4B/8N6zAvlw/xfWRi8SOYGL2Y/eIm1
f2rtl9H/Af7301Q=
              "]]}, "Charting`Private`Tag#115"], 
           Annotation[{
             Hue[0.8178174124757902, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrIQoAUEQLBRFFEUU
guIfSvYlD2ZfEx4z75uZbL7erjVyxpiCMSb5Qlf7+TnZptPFvlM/DROd6ctO
J/p+L9HR3lIP3sHGire3j9Q7XLizL8Xbcj54G3rw1pyH/Ir5rutfso55C+ZL
jj9nHbyIHvkJfdH1j716QN9xfmS/imdMNm+IuryVDyTbtwq+6P6J6Hsj5ivY
n/kW7pNn6ge4n/UI/8fjrUW/14Z18LfMz/A+7Me8vdz1+0qseEe5Kd7J4529
/S/eflf6P/b/000=
              "]]}, "Charting`Private`Tag#116"], 
           Annotation[{
             Hue[0.05388538997559067, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrIQoAUEQLBRFFEUU
ouAfSvYlD2anCY+Z972ZbL7erjVyxpiCMSb5oq7283Nlm64u9p3qaZjUmbrs
6kTd7yV1tLdUg3ewseLt7T3VDhfu7EvxtswHb0MN3pp58K/o77r5JfvIW1CX
HH9ODV5EDf+Euujmx14/YF7H6ZH9Kp4x2b5D9OWtdCCZvwq+6PmJ6Hsj+ivY
n/4W7pNnqge4n/0I/8fjrUW/14Z98Lf0z/A+nEfeXh76fSVWvKPcFO/k8c7e
/hdvvyvz/u+H00g=
              "]]}, "Charting`Private`Tag#117"], 
           Annotation[{
             Hue[0.28995336747539113`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRgdvYmknamG3d/AIgmLnVSxVLGw9gtUWVoEogiAIFgmRkKBI
Alr4h5KZ+MHsNOHxzbydzVa7w06vQkQ1Iiq+Upl9fblsn+sKXvtFXcBNrjN4
OikqtXnJ4kvsTfliey+Zdf7JPpUvsm/lC8HiC3CezB8xP+b+A1jO26O/wf4d
cvFtkcu8h7zO/SsnXyIfMS/sR/mI/vvOJTcvxUvzn2+L38k9cLkfuCX7Y34g
9zOPkmdyf+Rb+T+OLzD6vULzVv4Ivo28D/rlvNjclS8xN+VLTa58Z+wjvouz
/9XZLwP/AOQn0z4=
              "]]}, "Charting`Private`Tag#118"], 
           Annotation[{
             Hue[0.5260213449751632, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRQdvYmknamG3d/AIgmLnVSxVLGw9QqotrAJRAoIgWEQiwZAQ
AtFCE1Gys/mwO014/Jm3s5v2eD6atIioQ0T1lyuX5U+VnKrK5EfzwasrBfdV
Jehfr+qKZa6ZfQ9ZGL5IPjUrnXe3fKHlu8nK8AXo5/kreKn6L2A+7wxfT/lP
yNnnI+d5F3lX9e+t3EG+ULyTX8NH1Oy75VyUBjvirXnIfit3wXo/8ID3x/yM
7wfe8P1Fs5/P72P5AuT6fUVl+EP4jvx/0M/nReJl/l9RGL5Y5IYvwTz7Umv/
zNovB/8B0LfTMA==
              "]]}, "Charting`Private`Tag#119"], 
           Annotation[{
             Hue[0.7620893224749636, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamG3d/AIgmLnVSxVLGw9QqoprAJRAoIgWEQiwZAQ
AlFQE1Cys/mwO014/Jm3s5v2eD6atIQQHSFE/eXKqfypoqmqjL6aD15dKbiv
KkH/elVXTJlm9j2oMHwRPTUrnXe3fKHlu1Fl+AL08/yVPpqXqv+CnM87w9dT
/hNy9vlgnnfBXdW/xzznDvKF4p21nxANbzmXpcGObPYdst/KXbDeTzbnDXh/
zM/4fvKtecP3R7/P72P5AuT6fWVl+EP4j/x/0M/nRfJl/l9ZGL5YZoYvwTz7
Umv/zNovB/8BxP/TJw==
              "]]}, "Charting`Private`Tag#120"], 
           Annotation[{
             Hue[0.9981572999747357, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRAoIgWCiRYMgP
CSj4E1Cys3mwO83yeG++nZ1tDqeDUUMI0RJCVCdXLr8/VXKsKpMfrXdeVQl0
V1WM/HJRVSRTrZl3l4XBC+VDa4XzbhYvsHhXWRq8C/Lcf5Zvrecqf4LP9x3B
6yj+AT7zfGjud6HbKr9FP/sO/JnSG2s+Ier8mn0ytUP1vH3mW75L1nzQPZ4f
/RN+H720XvH7kfd5P+Dr/cHX+6XS4Afg7/l/kOf7Qnqa/0uFwYsoNXixxUus
+TNrvhz6D7rH0x4=
              "]]}, "Charting`Private`Tag#121"], 
           Annotation[{
             Hue[0.23422527747453614`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLJRIMOSH
BRE0BpTsbD7YnSY8ZvbNt5vmcDoYNYQQLSFE9eVS8vvTJce6clkY3gVVpeCu
rgTzy0VVscwMs+8hleWL5NOw1gV3xxeC2XeTpeW7os/nL/JjeK7nz+jzvhPy
dbT/iD77DmA+74Pben7r9D3wTPPGySdEvW/NfbLZozpvn/1UWH2fnHzgHufH
+Qnfj96GV3x/zB/4fbDfvB8570ul5Q/h3/P/wTzvi+hl/19Sli+mzPIlji91
8ufOfRXy/gGxX9MX
              "]]}, "Charting`Private`Tag#122"], 
           Annotation[{
             Hue[0.4702932549743366, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhQdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRAoIgWCiRYMgP
CyJoFJTsbAZ2XrM83sy3M7vN4XQwagBACwCqk6RV+TNSY6NCva3fBZUyzrtG
KfvlolKicuuJd1fa4cXqYb3BBTfBiwTvqj4O78I59Z95vrmpP4n5j9zfMfwD
58QL2VO/z75t6rci99jPjN+or8MDqO9bU46u97Cet098LJ3cRzEf+x7Nz/0T
2g9f1q9of64P6X1QvB+K9+Wc+BHz9/Q/XE/3xfh0/xe1w0swd3ip4GVi/kLs
q9n/Aadv0xE=
              "]]}, "Charting`Private`Tag#123"], 
           Annotation[{
             Hue[0.7063612324741086, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb8KwkAMhw/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4CRUKQiC4KBUimIp
BRH8B0ov1x/kshwfyX1J7qrdYadXMcbUjDHFKZHz+2eD+zYyfjleh0Wk4KaN
G+qnkyKunDoW34Vz5Uv47tjqwrPniz3fiT/Kd0Re7h/46Xhs6/fe/Dtww/q3
6Ce+CCz3V6iv2/olWPIBeGR5wV/lM6acdy550hxQ2a8tfnqr/Ars5kN9S+YH
D2Q/Kvefyf64H8n7kPd+5L0v8uKP4d/I/6Be+iX00P9LufJdKVW+m+dLMa/4
MtL/kWP/P5hX0wY=
              "]]}, "Charting`Private`Tag#124"], 
           Annotation[{
             Hue[0.9424292099739091, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb1qAlEQhS95E8t0QVOkm3fIIwQUO1/FUkOKtHkEqymsFlZZEATBIrIi
kV3kElLoRlD2nrsHZqe5HM7Md+en8zZ67T845x6dc/WL8FrdQuggxEkvUS/S
OkrqXoiC+e/TOo5aRg3ej3rDO+hv1AGX7lu8vMXb6b/hfdNH/VbPUU9C/oY8
/LdmfjfwV/TBy6hRn1A/hfw56+HPqMdBf+nV8Jxr+v2EL1bPpOG/gC+V8RPq
2B/zn9E/9RDzSTP/B+ZnfYb9SGt/0tovffBz8pa4D/Px30H+7H3FG95RCsMr
2C94JfngncTew3P+O5Gn0wA=
              "]]}, "Charting`Private`Tag#125"], 
           Annotation[{
             Hue[0.17849718747368115`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbFqAkEQhpe8iaVdiCns5h18BCFi56tYRrFI6yNcNUUqQUUQBMEiYjg8
7jiOpIlnIOH23/thdprlY2a+ndntDCeDlwfnXNc515yISus/HzryUeot8Gbd
REHu+chZP581kWkeGL6rVsaX6ldgr1t/Rr4LGb6z3o3vg/eh/6Q/gV99/ZH9
uO/A+ifv3zMP346M/hX50de/sx/5hDz1vNRf43OunfcNeakNJ9L6+/BH+ZVE
85GfMb+0+46xH3mB/Vm/w/vQH95P7H+d5W78F/q2+B/W475Uvu3/SmV8meTG
l3Me+Ipo/jLat+K8/4hH0vg=
              "]]}, "Charting`Private`Tag#126"], 
           Annotation[{
             Hue[0.4145651649734816, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9gtUUVoEoAUEQLJSIKBEJ
WvgTQcnO5sHsNMvjzX7zZrfc7rc6JWNMxRiTn1Ipf362uGvrxi+nl2FeV+i6
rQT941FeF06cFt6ZU8U78d1piwuP/Fa8GFp4B84Ubw9f7u+QZ2j7t/Bl3ga6
Zvlr9Asvgi/3A+iq7V94/hz7Dqye8VfxjCnyTsWnj9JzKnhN4Xt+AN/lg25I
firy92Q/ejo9kf3RH8n7gO/ej7z3pUzxY/BX8j+4L/NO9ND/S6niXShRvATz
hHf18t+8fVPk/QN7J9Lw
              "]]}, "Charting`Private`Tag#127"], 
           Annotation[{
             Hue[0.6506331424732821, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9gtUWVkKUgCAIFooSzA9R
tPCvULJv82AzTfiYN9/OZsvtfqtTUkpVlFLZF3XTn58p3TWV6pfllZdVQq6b
ivXb8niUVagjy/Bd9NXxBfpu2ei8M+fhO9EP31F/Hd+BeczvmR+a/I6M87bM
14x/wz58PvuYX5KrJr8o9OfkgeFZYT+lcp6iLx+H55LPN+Ev9Jfs2/3IDewv
+f493E+elie4P/M+/g/99v+J+15H+Tr+E/1rvA/zOC+Qh/u+cnV8oUSOL+Y8
fAn3hS8t3PdG/gNsd9Lk
              "]]}, "Charting`Private`Tag#128"], 
           Annotation[{
             Hue[0.8867011199730541, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTsKwkAQhhdvYmknamE3d/AIgmLnVSxVLGw9gtUWVoEogiAIFoaIJCYk
ksJHLJTsbH6YTLN8zL/f7KPeH/cGNaVUQylVrFwP/fmZ0kNTiX5b3rpFxeC2
qQj5+ayoUN8tsy/QqfDddGbZ6NxrxeeD2efpXPgumMf7z8hPTf4E5nlH5FvG
f0CffXv0eb8Dbpr8ptJfgyeGV/orfEqVvOQ+5YLXVM7vsp8+ou+A7fnAHT4/
9o/4fvS0vOD7I7/n96HK+5H8Lw999vvw7/h/kOd5N8qEL6BU+EIKhS+q+GJ6
CV9C8j8euP8fYS/S2Q==
              "]]}, "Charting`Private`Tag#129"], 
           Annotation[{
             Hue[0.12276909747285458`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3S6walQRRAEwUFRiqWl
rQ5qdVB6OX/IZTk+knyXu1S7w06vopSqKaXKkyPXxdeE7ptI9cvyKigjATdN
xKifTsqIdGSZfVedCV+ob5aNLrg4vjOYfSf9Fr4j8tx/AI9N/R7M9+0wX8P4
t8izb+P0++C6qV86eQ++keGF/gifUv9555wnyR79fW32UyHyPtjOh/oWz09P
ywN+Hz0sz/j96N/w/zi+Izn/i/nYf0Z+zftBP98X0l3ulzLhiygSvtjxJc78
Kcl95OAfUa/SzQ==
              "]]}, "Charting`Private`Tag#130"], 
           Annotation[{
             Hue[0.35883707497265505`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkjEKwkAQRQdvYmknamE3d/AIgmLnVSxVLGw9gtUUVoEoAUEQLCKKGJSg
Fmq0ULKz+bA7TXj82bezuym3+61OiYgqRJR/tW6S/UxJ11Qqb8vLMK8ruG7q
Ah6P8koksay+s6SO7yR3y0YXHj3fwfPt5eP4YuS6ficvy0PTv0Wu+21wnprx
r5GrLwLr+gBcNf0LL5/DNzA8k6/jIyrmnWrOLs+58DXVz5mTB2A7H/obOj8X
5+3p+fhpeaLnR3+k9+P5YvbuF/Op/4B8pe8D1v1O/HDfl1PHl/DZ8V0839Wb
PwXb/w/9f0lP0sU=
              "]]}, "Charting`Private`Tag#131"], 
           Annotation[{
             Hue[0.5949050524724271, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLCKRkJAQ
goUaGyU7mw+z0yyfP/vm72x7PB9NWkqpjlKqPrlKXf1M6ampQr+tPgR15fpj
dd9UBr1e1ZXqxGrmJboQvFiXVhtc8HB4kcO766/ghfD5/g35lqb/Cp/nXaB7
hn9GP/NO8Pm+D901/XvH97CfhdE7J59Sjd6yT1J71PCGzKdK+D60zYf+Aeen
Jv+M30cvqzf8fvSfeD8OLyRnv8jH/Aj+kf8HmufF9JT/S4XgpZQIXoa8zMud
/AXJ/ygx7w89d9K+
              "]]}, "Charting`Private`Tag#132"], 
           Annotation[{
             Hue[0.8309730299722276, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KAkEMRgdvYmknamGXO3gEQbHzKpYqFrYewSqFlaAiCIJgoSiyoiyL
hX+NsvPNfpBNMzwyeUlmis1uo1VwzpWcc+mJSPTz86FtH7G+Ai8Xadz1Hbjq
40YeDtK4ahQYvkhj47toEtjrFuec78R+8B05D3wH5lG/12fgvr+/ow/9tuSK
929YD9+aedTPyWV/f5bLTzlPz/NEv8bnXMZj5MXyVLL+dfjlY/Jzedv5yDXM
z/oO9pNs/xH25/013kdy7ye592Ue/hPrV/gfMvpd5GH/V2Lju0pkfDf2g+/O
eeGLxf5Hwv3/Mh/StQ==
              "]]}, "Charting`Private`Tag#133"], 
           Annotation[{
             Hue[0.06704100747199959, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTuKAkEQhhtvYmgm6wZmdQePIChmXsVQxcDUI0xUgZGgIiwsCAYrig8c
hkHwmbhM/z0/1FTSfFTVV9Xd5Wa30So55yrOuexEpPr6+NC2j0QfgRfzLGJ9
Bq75uJCHgyzOegoM30kT4ztoGtjr5vuCb8d58G25D3x/zKN/o/fAfV+/pg/z
fslf3v/DfvhWzKN/xnzV10/JyEes73me6Nv4nMv3HSMvliPJfXX45WnyM3LY
j/yN/SW/bwf3I49wf9av8D5SeD8pvC/z8O/Yv8T/kDHvIFf7v5IY31mOxnfh
PPhiuRlfIvY/UvI/KL/Sqw==
              "]]}, "Charting`Private`Tag#134"], 
           Annotation[{
             Hue[0.30310898497180006`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbFqAkEQhhffxNJO1MJu3iGPICjp8iqWUSxs8whWU6QSNAhCIJAi4cKd
xx3nWWhMGuX23/th7m+Wn3/229mZ9ujpYdxyznWcc9UJlfp389KJV6G/wW83
lXL6vldGP59VSjUJHryDFoYX6zF4j9v86NXwogbvm/2A98Uc9z/1Evyzr/9g
jvfeye95/p45eDvmuL8mr+vrX1mPfMX6qfcv+m94ztX9LpGL9SupeUPw5Wry
NX3oj36A/qXu7xH/o1/g/6zfYT7SmJ805ssc/Ij5G/ZDHt6L5WT3K4XhpZIY
Xsb+wMvlbHiF2H2U9HcbF9Ki
              "]]}, "Charting`Private`Tag#135"], 
           Annotation[{
             Hue[0.5391769624716005, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FSoUhAEwUGpVEWp
OqjVRenl+kOa5fhI8uUuV273W52SMaZijMlOiTt/fja4ayPht+NFkMUVXLdx
AY9HWZz56Fh8J06UL+abY6sLDgVfVPDtOVW+Hb9U/xY8tPUb9Mu8Nbhm/Suw
+EKw9PvwVW39vJD3cJ+B5Rl/lc+YfH9TyZNmj3JfU/yUqrxP+r0h6htyf8rv
15P3gSfyftSHsh/Md/tDvdsv5ok/Qv9S/gd5mRfTQ/8vJcp3plj5Lpgnvis9
lS8h/R938B8Oh9KY
              "]]}, "Charting`Private`Tag#136"], 
           Annotation[{
             Hue[0.7752449399713726, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbFKxFAQRR/+iaWdqIXd/IOfICh2/sqWq1jY+gmpprAKRAkIgrDFStZg
2E02xeJubHbJ3JcLk2nC4c6ceS/v+Pr+6uYohHASQui/qFa7vZXeWjW6jfyW
9bXSv8jnVkvmjw99VVpGhu9Xa+crdR3ZdNmC8/AVI9+37pxvzv2Yn5Gn1v/F
eez7JJ+Z/4MMX07GfErfqfW/jvKE55kYv+i/84Uw5M/IpXOcyOC7hJ+MPBV/
35z5Bc4vw/nucD/yE+7P/hz/Z+Sbsz/+X+bwF5x/x/uQsa+U1r+v1M5XyY/z
LbkPvpVsnK8R/x4t+QAC39KN
              "]]}, "Charting`Private`Tag#137"], 
           Annotation[{
             Hue[0.011312917471173023`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTsKAjEQhgdvYmknamE3d/AIgmLnVSxVLGw9glUKK0FlQRAEi5VVUQzL
Fj4rZTPZHybThI/J/00e5Xa/1SkRUYWI8lUqM++fK9N1lYLXq7yseXmuu7qj
Px7ldTNnz+K7Gqt8F5N6drrVCXnxJYHvaD7KF2O+5A/godu/D86/A9ecfwsW
XxTkl+Cq278I+nPkB45n5qt8RMV5p9Lnr+I5F/mm+MHSX7K+b8TF/IacH9yT
+/HT80TuD18k7xP4YuT9+6Iv/gT5jfwPWOZdONP/y1b5bnxWvjvmic/yQ/lS
1v+Rgf/vINKB
              "]]}, "Charting`Private`Tag#138"], 
           Annotation[{
             Hue[0.2473808949709735, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb0KwkAMgINv4ugm6uCWd/ARBMXNV3FUcXD1ETrd4FRQKQiC4NBSWyw9
Sgf/Oim9XAO5LOUjuS9J0x7PR5MWAHQAoP5SlOrzM6GmJgrm46EOrd6W+yZy
5vWqjkwllsn3UFr4UlVYNrrD3fHF3I98kfoKX8j19P7GvDT1V2f+C3PP+M9c
T77Aee8zd0393sl77FsY3qlK+ACaebeUx0qwh837IfmZKe+j3DfApv+A5mee
0X74sryh/dkX0P9xfCHKe0WcJ3/M+RPdh33UL8VS3he18GWYCF/u+DQ+ha9A
eY+S+/0B6GjSfA==
              "]]}, "Charting`Private`Tag#139"], 
           Annotation[{
             Hue[0.4834488724707455, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLAyJwZAQ
UvhbKdnZfDA7zfKY3TczO83hdDBqKKVaSqnq5Cj1+2dCj00U+mV5F1SRg7sm
MvByUUWqb5bZd9eZ8CW6sGx0Qez4ItRnX6g/wnfFfX5/Ac/N/TOY653g6xj/
EXn2HZz3Prht7m+dvAffzPBGf4VPqbrfNedJskf1+z77wZz3wbY/quv3uH/w
hOejp+UVz4/8gf+HnP8jua8QefZH8O15P+iH6yVUyv1SJnwpxcKXOb6cHsJX
kNxHifn/3YjScg==
              "]]}, "Charting`Private`Tag#140"], 
           Annotation[{
             Hue[0.719516849970546, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9gtUWVoJKQBAEi4hB1ERJ
4V+nZL/kg9lplsfMvpnZLbf7rU7JGFMxxmQnIrWfnwvbdfGwr5zXqywS+865
7iImj0dZXG2UM3wXe1O+s73n7HSryPOdPN+R88AXMo/7B843dPV75tFvR645
/5YMX0DG/SW56uoXXn7OeQaOZ/arfMYUPEVeNM+luN+En4z8UvS+gRT9G5hf
in172I88wf6sD/A+oucLxXtf9oP/RN8G/8M8+p0l1f8rN+W7SqR8sedL5Kl8
D9H/kZL/yaDSZQ==
              "]]}, "Charting`Private`Tag#141"], 
           Annotation[{
             Hue[0.955584827470318, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FRQKQiC4FBpKR4t
tYNaN6WXu0Auy/HzJ1+SS3s8H01aSqmOUqp5KSr8/Ezg1ESJb6uPhyYK1n0T
OeevV01oTK0m3gO14GVYWG1wh5TriZd4vDvWghezT/U3fFm9NPlXb/4L657h
n3l+4kXsU33Iumvy954f8DwLo3f4FTylnN6SD7XQAesh8T0/BLlvBK7/gOYH
N/+M9gO3/4b25/yI/sfjxeD9L/vET5h/ovtwPvXL4CnvC1rwNKSCl3u8gucl
XgnyHhX3+wO4uNJY
              "]]}, "Charting`Private`Tag#142"], 
           Annotation[{
             Hue[0.1916528049701185, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbFKA0EQhhffxNJOooXdvIOPEEhI56tYarCw9RGumsIqkIRAQAikUO44
stwRA+rFLuH23/1hdprjY2a+m5m9HD7cjy6cc1fOuf6LOGh3CqHjEHv9i7yY
99GSb0I0rJ8+9+G1igzfTr3x1dpGDrp5xX74ysz3pUfj+2Qe/Vv9jfwU6jfZ
/B/kQfCvOT98KzL6Z6y/DvXvZOQLzvMY+E3/jc+5xK/IS2e4kNR/Bz8Z+Rnr
43yS5rvF/OQJ9pO0/wv2Z36F+0h2P8nuyzz8JfuXeB/W43+1fNv3FW98Xirj
azJfKz/Gtxf7Hgfufway+NJS
              "]]}, "Charting`Private`Tag#143"], 
           Annotation[{
             Hue[0.42772078246991896`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KAjEQRoM3sbQTtbCbO3gEQbHzKpYqFrYewWoKK0FFEATBQtlFXFxU
8LdTNl/2g2Sa8JjJy8yk2Ow2WgVjTMkYk52Iu75/NrRt46ovx8tFFim5auPC
+uEgi0Rjx/CdNfF8J00dW90iDnxR4Dvqx/MdmMf9vT4d9239jj68t2V9xfo3
zMO3JuP+nFy29TPeR35K7lme6NfzGZPzGHl5ezwl1+EP8nOy60/yfmroX/J5
O5hPHo5HmJ/1a+xHgv1JsF/m4Y/oX+F/WI/3TnLz/1cSz5dI7Pku7Ae+lP3C
dxX/P+6c/w+noNJJ
              "]]}, "Charting`Private`Tag#144"], 
           Annotation[{
             Hue[0.663788759969691, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbFKxEAQhhffxPI6OS3s5h18BOEOO1/FUg8LWx8h1RRXHeQkIAiChZIj
JCTEgHpep2T+zQ+z04SPmfny7+7x5fXF4iiEMAshjF/UoD9/Vrq06vU78jYf
qyOfWrWcX92N1eguMny11s5XaRfZdPmO+/CVune+D/11vnf2sf/GPLc2/5rk
f+H83PzP7MNXkLG/IZ/Y/Jr76GfkG+NHPThfCFPeB/Rl7zgjn8Of9DfkmE+m
PGfIL9N5r3A++Yp8j/NzvsD9SHJ/ktwv+/CX9D/hfTiP/1Xy6d9XaudrpHS+
NvF1zAtfL/49BvI/mYDSPw==
              "]]}, "Charting`Private`Tag#145"], 
           Annotation[{
             Hue[0.8998567374694915, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9gtUUVoKKIAiChRLxh0gQ
/CuV7Ns8mEwTPmb22zfZYrPbaBWccyXnXPpFPfT986VtX4k+Ay8Xad31Fbjq
K+b8cJDWTaPA8F31YnxnjQN73eLE8/BFOd9RP8Z3IOP8nvn6fn6Xy7/lfMX7
N8wP35rzOD8nl/38LNefknueJ/o1Puey+8boi+UpuQ6/vE1/Tg75yDXklyx/
B/tJtv8I+7O/xv8Rm+/A+8P/JcMf8fwK78M+7jtLYt9XLsZ3k8j4YuaD706G
LxH7Hg/u/wd+0NIr
              "]]}, "Charting`Private`Tag#146"], 
           Annotation[{
             Hue[0.1359247149692635, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FRQEQRBcFAqam0p
glZHpZfrD7ksx0eSL7m7anfY6VWMMTVjTHFKPDn/2eC+jYxfjterIlJw00bC
b8fTSRExR47Fd+eb8l354djqVhf0iy/yfGf+KN8J+0n/EfuMbf3B23+P/ob1
7+AX3xYs/SG4buuXXj4Ajywv+Kt8xpTz5pInzQG4LX7KVT4Eu/2onNeS/am8
70DuB57J/VG/lfch7/3gd++LvPgj+DbyP6iXeVfK9P/STfliOilf4vlSb/+M
9H88wX9mwNIX
              "]]}, "Charting`Private`Tag#147"], 
           Annotation[{
             Hue[0.37199269246906397`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkj0KwkAQRhdvYmknamG3d/AIgmLnVSxVLGw9QqoprAIqgiAIghGDGBKC
+Fsq2W/3g8004TEzb2Z3U+0OO72KUqqmlCq+iLu8fiakbyKXp+X1qoiM3DSR
sn46KSKRyDJ8N4k931USy0a3itkP36XkO8vH80Xy9vqP8rA8NvUH5jFvz/6G
8e/oh29LRn9Irpv6ZSkfkEeGF/L1fEq5eXPktc+Bdvu14ScjH5LtftrNa2F/
7e5/gPNpd/4Zzs/6Le6n5IvI9n65H/wX+jd4H9Zj3lXn/vvq2PMl+uT50pIv
477w5czb/4/8B05o0gQ=
              "]]}, "Charting`Private`Tag#148"], 
           Annotation[{
             Hue[0.6080606699688644, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdksEKQVEQhk/exNJOWNidd/AIiuy8iiWysPUIVrOwuoWUUopcHYnoJlyW
dGfO/WvObG5//5xv/jnnFpvdRqtgjCkZY7Kv1IPePy5qcyX09Hoxz+pOL6+r
XDf0DwdZXengtfAu5BTvTBevGTc/BTwX8I70UbyYUnV+h3x97t8G+Tc4X2H+
Gr7wVtByPkKeMvfPAn8Kv8d6Ql/FMyafNxbfaj21Oa8ufGjxI5vqfPBrkt/m
8zuyn833H8n+6F/J/QS8GNrfL/IJ34G/lPcBT+adbaLf1zrFu9q94t0C3h15
hZfA9/8f9B862NH2
              "]]}, "Charting`Private`Tag#149"], 
           Annotation[{
             Hue[0.8441286474686365, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb8KwkAMxg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FSoIgiC1KFyUlpa
Sv1TV6WXayCX5fhI7pcvSXs8H01aSqmOUqp+KUr8/Ezg1ESBL6sPQR05vq3u
m8i4fr2qI8XQauIlqAUvxsRqgwseDk87vDt+BS/CSvy/4dPqpam/Mo/6Xbi+
Z/hnzhPvxJr++8zrmvq9k/d4Hwujd44/pRq9pTxI7UEz35D4rCnvQyX9QdN/
QP6h6T+j+VhvaH6uP9F+HF7E2u6X/RFf8/8j3Yf9Ub8YCnlf0IKXQih4Gfsj
Xu74L0Deo2T9Bx5o0eI=
              "]]}, "Charting`Private`Tag#150"], 
           Annotation[{
             Hue[0.08019662496843694, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkj0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqoprAQVQRAkFoaIP6hB
40+rZGfzYHaa8Hiz37zZTbHZbbQKxpiSMSb7Sj349bPFbVsJp04v5lndoKu2
rugfDrK6cOi08M4cK96RT05b3Pzg8WJ+K17EH8XbY56c3/HT6b7t33r5N+BV
LH8NX3grzJfzM/DKtn/q+QF0z+qJl8+Yr9Nj8emjdEB5nrrwKVX+DL7LB78m
+aE7sh/0SPanfL+V3A9590f6vSL4wo8p338p74M8Mu9Id/2+FCvehULFuyKf
8G5e/gTa/X/Qf/4B0ck=
              "]]}, "Charting`Private`Tag#151"], 
           Annotation[{
             Hue[0.3162646024682374, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkTEKwlAMQD/exNFN1MEtd/AIguLmVRxVHFw9glMGJ0FFEASLg/KlWluk
auuq9CcG8rOUR5LX5Kfc7rc6JWNMxRhTfClSfH9dYNfFA1/M61URiXDdRSz1
41EREQbM5LuhVb4Qr8xOt7p4Puv5zpgr30nqqf+IT+ahqz948+8xY645/076
ybcVpv4lpsxVV7/w8nPhgeOZN58xH+Yp5SFTPBdukh9eKr+UPM8n+QbNL9yj
/eC//4T2h//+W3ofz3eSfn5fyJXfim9D9xEf/S+Eu74vWOWLIFC+2PMl3vwP
0PdIhX/u+dG6
              "]]}, "Charting`Private`Tag#152"], 
           Annotation[{
             Hue[0.5523325799680094, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkb0KwkAMgA/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FSoIgiCxaFSqUpL
rf2ZlV6ugVyW4yO5L7lLezwfTVpKqY5Sqj4pMsx/OnCqI8Wv4YNXR8L5vo4Y
C8PrVR1v9A2T74WB8EX4NKx13sPyhczku2MlfAHn6f6N51vq+isz9btgabin
/WfMhO9k3Xc539X1e+5HeYd5oXlnzadUw1vKQyHYYR6SH3KRd6GU80Ez34Dm
Z57R+5g39H72n+h/LF8A1v9CJfwh+460H/ZRvwhecr8QCN8bfOGLLV8CH+FL
Qe4j4/o/0MHRnw==
              "]]}, "Charting`Private`Tag#153"], 
           Annotation[{
             Hue[0.7884005574678099, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdksFKw0AQhhffpEdvYnvobd7BRxAs3nyVHm3x4NVH6GkOngKpBAQhICQS
Gw0pNTHtWcn+mx8mcwkfM/PtzG4m13dXN2fOuXPnXP9FNNr++dCFjwN5G/ex
J0991PobeL3qo9I0MHzfmhlfqbvAXhd/jnzFyPehnfHlzKP/nf33vj7Vxpz3
xvpL739lHr6EjP6IfOHrn9mP/Ia89PykR+Nz7hT4EXnpDG9k6J/DL63JR2L3
TWSYZ4b5ybfYj/0P2J/9Ce5H7Hy5jO6X9fAX8hP4Be/DPM4r5cu+r2TGV0lq
fDXnhW9PP3wHcvj/WP8PqbHRgQ==
              "]]}, "Charting`Private`Tag#154"], 
           Annotation[{
             Hue[0.024468534967581945`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkj2KAkEQhRtvYriZqIFZ3cEjCIqZVzHUZYNNPYJRBUaCysCAsLCIMoO7
osz4lyvTr+dBTSXDo15/9ap76r1Rt19zzn0454ov6qrXly8d+Mr0FvR6VdRF
86Bbvs56D/pzWtRJ46DB+9ed4R01DdrjVin54CXkg3cgH7w9/Tj/y7wT7/+p
5N/S3/T8mH3wosr5JXXD+xc8j/6ceuz1TJ+G51ypv9GXh9FzKffpgC+56S/F
7htJmaeN/NRD7Cdlni/sz3kR7qfC29Mf7pd98BPm2eB96Me8o/zZ95Wd4Z0k
Nrwz84J3kczwMs4L/x/9b3WR0Vs=
              "]]}, "Charting`Private`Tag#155"], 
           Annotation[{
             Hue[0.2605365124673824, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkr1KxFAQhS++ieV2y2phN++wjyAodr6KpYqFrY+w1RRbBbIhIAiigUiW
YMiaxPgAK7lncuDeacLhzHzzc3N6ebu+OnHOLZxz0xcx6HD0odc+Ov01vUun
OGhv+sxHq6Ppx4cpGs1Mg/etRcCrtTLtcek+4lX6E/C+2B+8khr1n5z33ue/
R/O/MX/l+a/0wcvZH/UJ/aXP30b8DfWd1y/cf77gn+ln+DIGeiNz/QX40gd+
IiEvp3+O+Vl/g/2on7C/zPvmuE/EK+nbfanBr6QzneF96KNfLR/h+0oR8BrJ
Al7L+cA7kA9ex/3s/2P+P0R50S4=
              "]]}, "Charting`Private`Tag#156"], 
           Annotation[{
             Hue[0.49660448996718287`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkjEKwlAMhh/exNFN1MEtd/AIguLmVRxVHFw9QqcMToUqhYIgWGipFEtr
bb2A0pf3AnlZyk+S709e2p+vZ4ueUmqglOq+FA1+fjpwqaPGxuhL0EXF+bGO
Eluj97suCgyMJt4LY8HLMTFa44In1oKX4VvwUvYjXsJ+1P/g/q2uvzvz37h+
pPmRwwuxEv0+54e6/uzkPfbbaH3iee0Lfo0+Uh6k9sDyp8RnTXkfWjkfWP8J
zQ/Wb0X7gb3PgfZnHdL7OLwE5L1S9id+Bna/K92H68kvh0jeF2LBKyAQvJL5
xKuc+Wv2M/8fz/8H/xrQ9g==
              "]]}, "Charting`Private`Tag#157"], 
           Annotation[{
             Hue[0.7326724674669549, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxdkjEKwkAQRRdvYmknamE3d/AIgmLnVSxVLGw9gtUUVkIUQRCEgJFoSMga
gxdQsrP5ME6zfP7Mm5ndbQ6ng1HDGNMyxlSnRMnvrwseuyigD0EVllOvuy5y
+MtFFRkHXgsv5VDxEr557XDBg63ixdDCu3OheBGXqj7kl9dzl39FvvS7IL/j
+GfMK7wT+kn9HvVtl7/DvuJvOfN65vSGc8Uzpq5fi08fpbdU+33hk1X+nko9
H/yezA89kf2o3n8l+6P+JPdDet8Ivr9fzCP8mOp9jvI+8KVfQkf9vhQqXkaB
4uX0VDz7N3+B+f3/Q78fqZLQqw==
              "]]}, "Charting`Private`Tag#158"], 
           Annotation[{
             Hue[0.9687404449667554, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kksohFEUx2+mxEoWHgsbG6FIKFPkKEWyQikL0sgMCY1EeSxGkkGTx8Jz
xI7IgoUsdDCjjAaDPJPXaGZkmmajvjEfae499yy+r9u593fO+f9Pqq6zujmK
MZbBGIv8RQQxo2jnajmoop5HAOMqwjWtPhXPnJHwo8vb/v13oWIejy+s3Dae
sDUVF+Yj8YnW0g5Nr1FFwfPhVULb4WmW5HnQbt3o2n8OI8c5P7Bn9yCzYSRM
PDf2jd3/qmlh4r2hb9FkTbH9EO8VowoNdbr6H3r/hKbsbsuwEsI5fv8B4xPd
jQWzIap3i8fj5tqkohDmcv41Gi7fNVOfCvFceFS8MGFfVei9A0tivX1NegVz
+H0bbs1U9YxqZX4PLwdezJZkBSf5eR0fB6c9mmjJYyyGfxVcEXm4o7w478EN
vdcKPmwSX+QdUE71qT+Q/eWL/qGV+m8R84Gd5lsS80Mqze8S+sAQ6UP6gdSP
9AWpr+C7oZ/0Pxf+QBf5I+p5wE/+kb8g/SX/QfoveF9QRvsheH44p/0RvADE
037R/kE67d8/voNa7w==
              "]]}, "Charting`Private`Tag#159"], 
           Annotation[{
             Hue[0.20480842246655584`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk0oRFEUx28mShazGixslIgioUg4SilLlLIg+ZZ8jGRKlCnJoMnHAsOI
HSkLimahYxrJyMdDiZKvpzGTaZqUeuM90rx77lm81+3c+zvn/P8ntbmvpi2G
MZbJGIv+eYQxo2TvZi2sYbseIUyoUmu7/BpenEcjiNJHz/fflYb5enxi+a75
lG1q6FiORgC7KnoNFrOGnOdHNHW7z7IFz4c7zu2BwycVddz5O5oPjrIaJ1Ti
yTg8df+rpavEe0V5xepM8fwQ7wW/ijvqmxt+6P0jjuUM2seVCC7p9x/QmCg3
FS5GqN4duqdtdUklEczT+bfYev1mmAsoxJNwv8wxc7yh0HsvlsZ/DLe0K5ir
3/fg9kL10GSRyLtQGnm22ZMVnNXPW3g/Ou8zxAkeY7H6V8F1ngeJ8vzsgkt6
X8T5IPg874Uyqk/9geivgPcPbdR/J58PxHyrfH4w0fwS1wespA/pB0I/0heE
vpwvg4X0v+T+QD/5w+v54IT8I39B+Ev+g/Cf8z6hkvaD84JwQfvDeSEw0n7R
/kEa7d8/fnxbfA==
              "]]}, "Charting`Private`Tag#160"], 
           Annotation[{
             Hue[0.4408763999663279, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl8oQ3EUx68ppTzwoCiFl9XetInFw3mhPGrZi6JMQ1KeKKI888DTsqUh
UasZWa1WcpQ/tYytzI1aoa1rs2u/bWwjHrT7O7/zcG+/zu/3Oed8v6fdNmux
6yRJMkiSVPnzyOG4MT4SUxhOaJHFvH1e/lMY3oYroeJJXQDm3hiatMhgccXt
7kkxdDkrkUaffN0wkGbIeSn01a8VHO+Cp+CBYbK6VWWo4cJJ7B6r8cofgpfA
pUtrv58J3is2Jc3LnrzgveBesy5z+Cnex/G4pc0UKDLc1O4/oWE4vnpaFvVk
vNk6U2M/DI0a/x7Pner2oJQjXhRrY4/WYDJH70P40KhEjUcF7NDuX2Bi3b9w
5f2ifBB7I78zhukSbmhnD1r0+65RRxmFglXa9xt3eB6GKM/PQeij92bOh2fi
83wIIlSf+gPRXyfvH0T/U3w+CNN8W3x+0NP8Ua4PCH1IPxD6kb4g9OX8BCyS
/nfcH+gif3g9BXbJP/IXhL/kPwj/OS8DJdoPzlNB7A/nZaFA+0X7Bzbav3+o
cmab
              "]]}, "Charting`Private`Tag#161"], 
           Annotation[{
             Hue[0.6769443774661283, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8ow2EYx3+YUlyI4qC4YGnRKIp6chMH/1IOOJClmUg5uLnOxXIQQ7nI
31AOGsv3ILQMKzYUi5kh2k9oKxba733e5/L29rzv53me7/fJ7xpo7klUFEWv
KEr8FPGOCVt1SveMCpMWYfQ11h7pZlWcuOPxhlTrWFJoTkWZFq8IeDK83/Mq
7NPxeMFQm9NZsqBC8J4xmr5aZF6RvBAMhc0G66YKDecOIie3eNi0LXkPCLY3
DV7uSd49KiwdgfVDybtDZl2/Eafy/w0MeTuffp+KKe39NXSNgZOIX9bz4bbP
HGt5UmHU+OdwdiwtpsUkz4Pki6tWR/Cd/7twkRXyGDc+UKq934d3fGvkYO2L
8w5Unf1Y9OYIbNp9GQ0FC/bOySikgr9/8YhiXuSpnvPi7qAa/l8p+ORnvsi7
6Jjrc38k+ysX/dMu998r5iM536yYnxJ4fo/Qh4pZH9aPpH6sL0l9Bf+BHln/
U+EPZbM/ol6ICtg/9pekv+w/Sf8F75XkfgjeG8n9EbwwWXi/eP/Ixvv3D1xk
X04=
              "]]}, "Charting`Private`Tag#162"], 
           Annotation[{
             Hue[0.9130123549659004, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8oxFEQx19uLi7O2/pTysrfXaEwtFxoS5I/tSciDkhJKCl/ThzsQaFd
KRwcRGkPq9UcXGzY1pKNVv6LrH0uDhKr/c3MXF6vee8zM9/vZHYONnenKKVy
lVLJk+IT61r0761JY48RcRxpmuprNGs8PUlGDB9q8ndmsjVajXjH8MFm+pBF
48pyMt7w+mMs9GTVSLxXLPBbqjZAeC+YEk4b6HZoNHAnT3iojx1hp/AeMaP0
u36uX3j3WJ3j3bdMCu8O57q8ZQ0u+R/FjgvT/Py6xiXj/RXa9oan/F6pd4mz
8cXExJHGEoN/jtHxkurpmPBCmNdenBX5kf8BrPXsmod+NRYZ7w/R0+Jqc/1J
3oeF2yroTGhcMO5b6KmsMEcSwlMqlXVcozyscp7uPsjn/+XEBzfzKR8AO9fn
/kD6s1H/cMP999J8MM3zuWl+kPlDpA+0sj6sH4h+rC+IvsR/BNE/SP6A+EP1
XuDrjPxjf0H8Zf9B/CfeO4R4P4gXg2feH+LFYZT3i/cP7Lx//7hVVfU=
              "]]}, "Charting`Private`Tag#163"], 
           Annotation[{
             Hue[0.14908033246570085`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8oxFEQxx8lcdmTw1I2fy5ayb+DkoaNopTCjYO2yEHLtheFQpSUcrEh
IiK0KXGwB035c1CWjRBJtBJ2e2+zyd9F+5t5c3m95r3PzHy/k2HvrG+NF0Lk
CCFiJ0UYuz76PXMOiW1GSPQ7TcPZTom+o1iE0HbgsSx2SywyIojuc6s5NCRx
eioWz7i1Xn65MSGReE/oG2pxj65p3iPO7CdWR3YlGrijB6zIPKlpuNW8AObV
DZjjfjTvHjdtjX3VaYp5d/ht9S25ShX/v8Ede+7LTZPCSeP9FQbGW1+zehXX
u8DUSHpx46zCQoN/hktuy8r2qeb5Mbkg+GtX+v8hit2U64M3hfnG+z38rF2I
Vn3pvBfDqqPHFVU4btxX0WkaHGv+0zwhkljHecqDg/N094Lk/yXEh3fmU/4Q
Erg+9we6v2LqH5a5/3aaD/R8MzQ/6Pn9pA94WR/WD7R+rC9ofYkfgFzW/5j8
gTL2h+o9wgj7x/6C9pf9B+0/8YKg94N4Iajk/SGehBPeL94/cPL+/QMKZVvK

              "]]}, "Charting`Private`Tag#164"], 
           Annotation[{
             Hue[0.3851483099655013, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kjtIglEUx68uRRD0WCOxra2HUvQ6PVzKLWipqUiLIFqyoddcDSpBVFai
RUMFPZbA6QxNhpppiVZQYYnx9X1f5FAkVPjdc89yuZx7f+ec//8YR6b6bXrG
WC1jrHDy+MCb2OBHpVNGuxYKti52VelWZQyHCvGOvam96MmOjI1aSOg1DlgS
pzJ6Ngvxhq5YtT9/KSPnZfGzxWSekwQvg8nZsexSuYIaLvSC9lRO19SmEC+N
e0vLMwsTCvGe0Tl95ujZUoj3hI5688pkWPx/wLJIX/z7T8EN7X0Kb3WPNdYG
leol0O9+NSdtKjZo/Dh2unSxo2OVeFHMG9cN53cq/Q9isTTUrn9TsU57f4He
tfsrQ07kA1gijcYsPyq6tfsBWr4O592/gsdYEeno43nopjy/B0D8b+Z88BCf
54NQSvWpPxD9mXj/IPof5/OBj+bb5vNDnOaPcn2ggvQh/UDoR/qC0Jfz07BP
+ke4PzBM/vB6Gbgm/8hfEP6S/yD85zwJdmk/OO8drLQ/nKdAB+0X7R+I/fsH
BkhbDg==
              "]]}, "Charting`Private`Tag#165"], 
           Annotation[{
             Hue[0.6212162874652734, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kj1IQlEUxx9CtTQVQmMWgUVDaEMtHmwpKAiEhIaWRBEyIgqJklBJCFpe
RFDRENjS0hA0GMShclAwkT4NtBTFNN9HSxhRGL577lkul3Pv75zz/x/D7ILN
qRMEoVcQhMbJ4hPfMsm1mE9ClxYKLkdXsnNBCW8TjZCwGNLPm3YkNGtRRd/F
uv3sVMKD/UZU0N8ZGLM8SMh4Zazpx1s+dDLxSuiJNSXFYRk1XKKIIz2e7axX
Jl4Bj7+vF6ciMvHy6MgWZpx1mXg5tFqiRu+oQv8zKDr70m2ignva+xcMZbau
7GmF6j1hfvexo7VLRZPGv8fEtNnv9qvES2HCWCtKlyr9j2Po3FXvf1ZxQHt/
g7aJctlQ4fkI/rY7uu++VBS1+wkGJ8Ow9Md5gtBMOh6xPAQoz+4R+KH/Q4wP
nM/ycdik+tQf8P4GWf/A+3ez+eCV5jtk88MGzZ9i+gDXh/QDrh/pC1xfxi9A
mPRPMn/ASv6weiVwkn/kL3B/yX/g/jNeFVZpPxhPgnfaH8ZTgO8X7R/kaP/+
AWM7XBE=
              "]]}, "Charting`Private`Tag#166"], 
           Annotation[{
             Hue[0.8572842649650738, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8ow2EYx3+0TckOO8gcHDgQSRoHtfKsKDYHciCXTcM4CDm4kouU5LY/
aSmlllIoWg7Pag1jm0lWahZtren97ffDWUv7vc/7XN7envf9PM/z/T6t7tXJ
hVpJkjolSaqePL5xvm7X5LIy9Gih4EM0sqgfYphMVENGL9ZY7mcY9mnB0OFb
N5g3GQb81fjC7Y0rXf0FQ84rYXJsTu/8EbwiNtnc1h2rjBouUcDGV4fzel8m
Xh5vzrpjckkm3icOhisx3WiZeB/o6rAHM6Ey/c9igRmbPQ0K+rT3b6g+brG1
FYXqZdA4exr7fVbQovFfMNdzxyojKvHSaN6znXT5Vfofx/NM2/J4RMVe7X0U
A46p4ERW5MN4mzsebvlW8UC7hzDVPu3Q/wmeJBlIxyOehyfK83sYYvR/gPPB
S3yej8Ml1af+QPTXz/uHd+p/ic8HYr5DPj8oNH+a6wN50of0A6Ef6QtCX87P
Q4T0T3F/wET+8HpFMJF/5C8If8l/EP5zHgM77QfnyeCn/eE8BVK0X7R/4Kb9
+wfML0/Q
              "]]}, "Charting`Private`Tag#167"], 
           Annotation[{
             Hue[0.09335224246484586, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk0oRFEUx2+Tj70a02TEkGKHUVjoFAsbKXbKQmo0U2Kht9CEqbFTPjbT
kGJBUhYk+Vg4SWg0o4mhZMQgee/NzENKpEbzzrlnc7ude3/nnP//OPuHu90W
IUSNECJ3Urzjg7FqTJ2rOGBGBh0j3kN/XMVoJBcpVJYqfeWfKrrM0LE+frKz
WaHhwnwuVHzy+q3CrSHx3rDIl9c3tKsx7xWdycKNb5uOJi7yggfBqrvWSZ15
z1gcOk1s/+jMS+J1tsQdUFLMe8S2rNeT/Erx/wTarZeZBiWNIfP9Lbbc2/Wz
rzTXu8FSu2VlVslgvcm/wpnpxuZAvsG8GDZ3ax/BQYP/hzF65OtUVgysNd8f
Y7ZjbWwrIvP72FPWNVetGjhr3tdxwj9R1/4reUIUsI7LlIdxztN9H3r5fxPx
4Y/5lA9DjOtzfyD7a6D+YZr799B8IOdbpPlBzh8jfcDG+rB+IPVjfUHqS/xn
cLD+F+QP7LE/VO8VpH/sL0h/2X+Q/hNPBxfvB/FSMMr7Q7wMyP3i/YNb3r9/
mYdXmA==
              "]]}, "Charting`Private`Tag#168"], 
           Annotation[{
             Hue[0.3294202199646463, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kj9IQlEUxh8NDZJLf6gxqaCIIErJWs6kRDUVUZBQRIYh9HLJEJpCKCJq
y8TB1agIcrGhAzWUZilEhdSgaPaePn0OIbVU+O65Z7lczr2/c873HcOiOGmv
EwShRxCE2smighe/h6eNvRIua1FGd6y9Lzgk4UO8FgpuWl2RH5uEg1oUccEw
5jX6JfQf1UJGt+njL1GSkPEkDDd7SzgtEy+PSkj0eBIyarh4DjOdYYdutkC8
LILN8tWlFIiXwbdPvTixXSReGjtm4nKlW6H/7/iqC+/fxhT0ae9T6Bxx6/ec
Jar3gndT1h2loYwDGv8JW++rK/pImXhJnN9tWpszq/Q/imempeeTLRX7tfc3
uHoVGB2/5PkI+q9dUjWt4oF2D2GuxX48/K0iV7CedAyyPGQoz+4R8NF/M+OD
SHyWj8I51af+gPdnZP1DG/XvYPMBny/A5gc+f5LpAynSh/QDrh/pC1xfxs+C
hfR/ZP4A94fVy0Oe/CN/gftL/gP3n/GKwPeD8RTYoP1hvDKs037R/gHfv38Y
cFfr
              "]]}, "Charting`Private`Tag#169"], 
           Annotation[{
             Hue[0.5654881974644468, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kj1IQlEUxx8OEoHQ0lpENDRVfkCLnSFqiFra+0DIQogGo9khGkpIiMBK
IqQic6iEKKcjSJigIUlGaFQY14/3fE/ICKMhfPfcs1wu597fOef/Pz2OlekF
gyRJ/ZIktU4edYxbu6/iMwydeqiYD17HzMsM06lWKFjxDPx0HTC06CHjuRSX
FxnD/b1WVNA14B6xTZWQ88p4OtT7a0iXiMewjNaniKOMOi71iTtN5g62V4hX
xMDYxVwiViHeBx6HRo1ZT5V477huy0vOcZn+F3CiYbl3mRT06+9f8LbNdPn1
qFC9HJabZ9kOfw3NOj+LdpdxPupQiZfBzruaN/in0v8kbhdW14yzGg7q7+OY
bSTrfSca5aO4ET4Mbz1r6NPvIbRHdjdfvzUUChpJxyOeB5Hn9yiI/8OcDzni
83wSfFSf+gPRn5X3D6L/JT4fMJovwOeHG5o/w/WBSdKH9AOhH+kLQl/OL4Kf
9H/g/oCX/OH1GLyRf+QvCH/JfxD+c54MIdoPzlOgSvvDeSoUaL9o/yBB+/cP
3RJdMg==
              "]]}, "Charting`Private`Tag#170"], 
           Annotation[{
             Hue[0.8015561749642188, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx99WZsQFLSIr4kZuZJKbOTcuWObCHTcrIlcoJVaS5EJhI8nH
Jm42lHI7H/2LpNV8NKWEGvvANhtJudTec95z8/R0nud3zvn/T1XvcFe/TlGU
WkVRsifHF5yFvlZHXxQDaqSR7Ki0F49FcRXMRgrrOfrf/oMozGokcTYx+1hm
iGFjPRsfMEwWj/7OxMC8d3RuBea+TXHhxfFnmTbaQnGouGAUdmP3q8/9JrwI
Bk0jRTXj78J7Qbcn79ll/xBeGNamzQuvLSH/n7B5qAsPWZJYU98/oD2Bnfq6
lNS7x35JtbOg9BMNKv8O+YsjEa8uLbxbTE85Qqv+tPwP4CjkvFkxZ1Cvvj/H
YqNj2bqQkbwfx/uTp4lgBi71vody6/yl+ScDTUG96LjNeaqQPN/9dCr/m5lP
88LnfIBOpL70R1p/jdw/5Ur/gzwf7cp8bp6f2mT+W9aHPKKP6EeafqIvafoy
P0Ka/tfsD/WIP1wvTkoL+yf+kuav+E+a/8xLEmQ/mJcij+wP89IUk/2S/aMl
2b9/I49Ksw==
              "]]}, "Charting`Private`Tag#171"], 
           Annotation[{
             Hue[0.03762415246401929, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx1+fk5oL7YJEWU2WlNiFmzlXvlJiKy6UtPJVsogVLshHzZ18
1CzJjQu1XXChVtohUqv5SmRSY2M2m70uFC5Ie895zs3T03me3znn/z+lFqup
N12SJL0kSamT4gM1+r2GImMI+5RIYqXry6Y1h/DMn4oEHhjcAfdqCGuUiOOu
IziqlcLoXE9FDIOnusLgchiJF8XuuXl1a/Mz8yKomtGM/5a8oILzP6P63nPj
zYswL4ztF5OD5/mvzHvCtk67JksXZd4jLoz8TRdDjP8/YH99xWFZ1xs6lPcB
3DCXxybG4lzvFjvr9mc/FxNYrfCvsXFzYvvH8c68S7xLBLwWa5L/+3Cl58Q+
lCljlfL+GHOvvoePR2XOezDHlTFTcCTjknLfwanPFpvxQ0ahYDbruEV5EHm6
e0DF/2uJD4JPeR+scX3uD0R/Buofmrj/AZoPOni+DZofnDz/JekDVtaH9QOh
H+sLQl/ih8HE+p+TP5DG/lC9COSyf+wvCH/ZfxD+Ey8Obt4P4iXAy/tDvCSI
/eL9g3zev38IzUwH
              "]]}, "Charting`Private`Tag#172"], 
           Annotation[{
             Hue[0.27369212996381975`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx99WVsKdMilyobhbZk1cHLcUQhrFyuQjJfckSna12lbKZ1lx
s1I+byacC4nJx5CxEu/sNWafCheUtPec59w8PZ3n+Z1z/v9Tah1p7dNIklQh
SVLmpEhj3a68X373hP1qJLG7a9zQnCXj+Vkm4lhilHofW2Q0qBFDx4un3Hop
48J8JqJotx2snYyGkHhviA7L9HPzM/MiqMsPGSfqw6jizhScmZo6dvUozAuj
3a1ps7hemBfC4eXc3u2rCPNkvB3NU0xFb/z/Acd1HUOv/VGcU98H8W8v71O7
/s71Anh/tJGjpGNYqfJv8MucXRcsSzDPjwWBFUVfnOT/PtycHDCt+pOoV98f
oremIbLYnuK8F5s6J64Ld1LoVO8e/PpInP7GUygU1LKObsrDN+fp7oVG/l9N
fBB8yvtgi+tzfyD6q6L+QfQ/SPNBkOdbovnhh+f3kz4wxvqwfiD0Y31B6Ev8
MDhZ/wvyB2bZH6oXgVL2j/0F4S/7D8J/4sXAxvtBvDiI/SFeEsy8X7x/UMv7
9w/AZVYI
              "]]}, "Charting`Private`Tag#173"], 
           Annotation[{
             Hue[0.5097601074635918, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kktIQlEQhm8Py520SnpAD8KMMLEiwcUQLVy0StxHUWKgphCEu5CIVhGh
oiIVVJBFQbQoVwMFgmQmBEEp5SNN8xUkQYsgvGfubA6HOeebmf+f3vll3WIj
x3FyjuPqJ4svPPQ4J6/eXtDARwX3zF2ajs443kfqUUJ3i6P54S6Oo3wUUSda
vXGUE+jz1qOA3tljU4/9FRkvj0uWcsOaKkm8HK7IohKnLoU8LvKOP7Gm35gr
TbwMDrZrL6y1DPFSuH6m3eg3ZImXxKBM7Dekc/Q/geebxnDrXB49/Ptn/JTb
B9riBar3hFmJ+vpvuogqnv+IGv2l0hYoES+GNumBYjhUpv9h3OoWT+k9FVTy
729xJLRgTY5XKR9Ey45ZUjuq4jZ/D6D7u09qLVRRUFBEOu6zPLgoz+5BMNF/
NeODgvgsHwahPvUHQn9jrH+YoP6NbD74oPn8bH4Q5o8xfeCE9CH9QNCP9AVB
X8bPwBDpH2X+QJH8YfVyYCX/yF8Q/CX/QfCf8YowQ/vBeCXw0f4wXgVOab9o
/2CX9u8f1HpIyQ==
              "]]}, "Charting`Private`Tag#174"], 
           Annotation[{
             Hue[0.7458280849633923, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kjtIglEUx79eGK0O4eBgRiAiiYUUFQdqagiiIQKXCkqhoc2hyQpqyKIG
xfpKKgkJc3EJQThENAhmQmlZka98lM/NCInwu+c7y+Vy7v2dc/7/o1hcnVlq
5ThOxXFc82RRw0a/uiNhi+KyEBWUK/t6fPEo3oeaUcJa9Max4YrhgBBFlFpl
3vnKMx4dNuMLt+dy03pfHBmvgE6DpdTIvBEvh1bVb11i/kABF/rEA16i1V0l
iZfBtcB1t3s0TbwUBhILLal0hnhJVGt2e+S2LP1/x9r67GtyMo8O4X0cx6fa
PE8/BaoXwy1P8WSF/0adwH/Esd6Rh5qyRLwI7t1lNRZjmf4H8czCh+yGCmqF
97eY36zbnNIq5f1o1Mu6vPYq7gv3S7x4cYf5bBVFBdtJx1OWBxfl2d0PJvo/
xPiQIz7LB+Gc6lN/IPY3yPqHYerfxOYDcb5jNj9M0PwRpg+USR/SD0T9SF8Q
9WX8DJhJ/zDzB3bIH1YvBzz5R/6C6C/5D6L/jFeETtoPxitBg/aH8SqgoP2i
/YM/2r9/gWBYTQ==
              "]]}, "Charting`Private`Tag#175"], 
           Annotation[{
             Hue[0.9818960624631643, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx9+0mgtX3ElsdqXmI6wkOsnNWEm4IaWEhJCyLBIpkpLPfKSI
Cyntwo3cOCK0GjbzMYu8s7Vebd65Ii6kvec85+bp6TzP75zz/x9ja19de5Ik
STmSJCVOik+0WU6qmr9vsEMLFXPL7HK/1YNX7kTE8GAxVus3e7FIiygafmG0
ZucW19cS8Y6GfPlnf/sOiafg4mbNkiPzkXkRHKrcs5fqA6jh3GHstQS6g9Uv
zAthmt18sdslMy+IE2O67GHrG/NkHHc2K96iMP9/xulLvenaGMFV7f0TGixf
jvlkhes9oD8+ONDy+o6FGt+Hpw2HMLMcZZ4HjU36tsakD/7vwtn6v5WpdBUL
tPdn2O10K2FV5fwR3vv0KbbJOM5p9z08z3KOjAXjKBTUsY5blIcLztP9CMT/
EuJDD/Mp74IFrs/9geivmPqHY+6/k+YDMd8GzQ8ZPL+H9AGhD+sHQj/WF4S+
xA9BKut/Tf5AJ/tD9SJQwf6xvyD8Zf9B+E+8KJh4P4gXg0PeH+KpkMf7xfsH
5bx///3STWk=
              "]]}, "Charting`Private`Tag#176"], 
           Annotation[{
             Hue[0.21796403996296476`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kjtIglEUx78eEjQ0OEiIIDZELSJlJDUcTGhzcWhoCJEMK0qEoKWpFwgV
TWUaFVRDUbS0SOBBk8xQMR+BYGD5KNO0JaIHEn73fGe5XM69v3PO/38UJqvB
3MhxXDfHcfWTxQcqHGMGe6cfJ/io4Mi0uLEQ82M4VI8ybvx5D/3xG+zlo4RS
6/GyU3aHzp16FFF5ZmpIOyLIeK9oWdQODElixCvgnivVMTmaRB4XyuG3Si91
NaeIl8XAvsgzWEsT7wnvp7p0K9sZ4mUw3ye/qnme6X8azT+n48piDh38+xTa
uLxhrfWF6j2gXaK1iduL2MPz47jedmScr70RL4ot59xSfqtM/4Poc1x+6ZLv
qOLfX6NPlvj1BSqUd+NnWR1LzFVxk7+f4KxeE5Y/VlFQsIl0PGB5mKE8u7tB
+K9hfPASn+WD4KX61B8I/alZ/yD0b2HzwSrNt8vmByvNH2X6gJH0If1A0I/0
BUFfxs/CLekfYf5Aifxh9QpwQf6RvyD4S/6D4D/jlUBE+8F4ZVig/WG8CgzT
ftH+QT/t3z8vXFAF
              "]]}, "Charting`Private`Tag#177"], 
           Annotation[{
             Hue[0.4540320174627652, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx98QF/IRN0pIkdxIyOzqXNHkxkcohVoj0RJuVgutZLJaIsWS
vVyQaM2Fiy3tlOViNZqPfNPWWNhr242PckF7z3nPzdPTeZ7fOef/P6Xa0faB
FEEQKgVBSJ4UCZw2LG3ufjlwUI4Ypv9spdl/nXjiT4aE+/rZr/yJA6yVI4rd
ekuW5/gQbavJeEPTmZCIaL1IvFc0ZjTt6Ww+5kXQPHXX3DIWQBnnf8ZMSSOW
mC+ZF0Z/bv/yxOcN80KoznabqjYemRfE6orF3lJViP8/4PVM7rhODOOK/P4W
y8prHDl/L1zvCu1uU+Fx4yvWyPwL1E+2HsT73pkXQENVvdhRLvF/H3rynO53
ywdWy++92PUU7Glej3HehUvWovk2bRwX5PsOqq3DZuNNHBUFU1lHkfKg4jzd
XbDI/xuID53Mp7wPjrg+9wdKf3XUP4xw/0M0HyjzrdH8UMzzB0gfOGd9WD9Q
9GN9QdGX+GG4Z/1PyR/4jpI/VC8Cc+wf+wuKv+w/KP4TLwoa3g/iSbDN+0O8
GBTwfvH+QT/v3z/hAUxw
              "]]}, "Charting`Private`Tag#178"], 
           Annotation[{
             Hue[0.6900999949625373, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8ow2EYx3/+pO2gHDgtSU6ctCG7eHLaiYODgyRN5CBKVooUNyErkT9r
tlI4EBda4ZF/WWab/BpDxqzftvZPXISk/Z7nfS5vb8/7fp7n+X6fcvNAS3eu
JEmVkiRlT4p33LW0PJ9/r0GPGmkMB8xDA+tOuPZkI4n5/rmrHO0sGNRI4J/m
uG4tZcXlpWzEUWsoLDTZt5F4MTSMlVQGig+ReAqebfeHmlYuUMV5ImhZde4U
b/iQeG8of51aug5k5r2i1jSus8WCzHvBZ83C6LAxxP+fsLNMLro3hXFRfR9E
41h0pE+JcL0AOu2NoaPeKOpV/i1GlNIm/X6ceX7ca39sk7cS/N+Nn9M+na0h
hdXq+1MMnVRMTA6mOe/CX43de9mcQat638SCV9/M/G0GhYJ5rKOD8iDydHfB
D/+vJz48MJ/ybvjg+twfiP5qqH8Ic/+9NB84eD4bzQ+1PL+f9AEz68P6gdCP
9QWhL/HfIMj6e8kfaGV/qJ4Cw+wf+wvCX/YfhP/ES0AH7wfxkjB1Q/tDvDRU
3dF+8f6B2L9/FSxQig==
              "]]}, "Charting`Private`Tag#179"], 
           Annotation[{
             Hue[0.9261679724623377, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx1+mbUpyodZKsVygXMzHhdycWjK1RD5TiikiShRFiHLlSqJG
knxkKImk3ThDZLL1lm3lq229GmszbuxCifae856bp6fzPL9zzv9/DF2DDd2p
giAUCYKQPCm+0FrYtep1XUCPHHFsrP/2DQTOwX2XjBh2aK0RyXIGZXJEceo3
P/u9/QRWlpMRwT5D1sJa4wYQ7x0zV1Lq5tJsSLwwDuW1tJmvTlHG3b2iJeHe
S3+8QuJJWDt6ODnbJCLxQlhq3z62qf1IvCC+6ezDB8En/v+M1ZEcTyIQRJv8
/gGN6tDej1Pien4cv849rJ0JY6nMv0evSmuf1kSYJ6Jf95xYNkb5vwtvMpxH
Yx8xNMrvL3GroN+3VBXnvANLdja3TJWfOC/fd7FVv/gy6PlERUEV67hOeWjm
PN0doPyvID7sM5/yLrjl+twfKP2VU/8gcv+9NB9M8HyrND8U8/wi6QPA+rB+
oOjH+oKiL/ElqGH9PeQPmNgfqhcGPfvH/oLiL/sPiv/Ei0In7wfxYvCnof0h
XhzMvF+8fzDC+/cPjB1KSA==
              "]]}, "Charting`Private`Tag#180"], 
           Annotation[{
             Hue[0.1622359499621382, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kt8rg2EUx9/YBZIrlJuNNYobwoVycdxywSJ/AJqmrF34sQtF7MINvZIf
7+TCSqJQoiTlJNZ6axirZcUYs72z9ZKrJaS957zn5unpPM/nnPP9nqp+Z7ct
TxCEWkEQcifFJy4ZF+MOZxAGtVBxxGJNFkRv4CqQiwzW/brFSCwATVqkccqN
qvDrhzVPLlIop/a95s5zIJ6C3+1hsezvgHkJbO0pKvTOuVDDBeJ4/OVTTF3H
SLxX3D4rHz6d9CPxYug1usbGf26ReM9YuWvfFGz3/P8BQ8sv9qG7KEra+wjG
LvtHK8QXpHphnHnOenziGzZq/BDWmJOSyaowL4iGiSfH/d47/5exz6rYtqQM
NmjvLzBuqF+dLlU5f4KPHUcuv+UDF7T7Dn6XHM4Xyx+oK5jPOm5QHrKcp/sJ
RPl/C/EhxnzKyzDA9bk/0Ptrpv6hmvu303wwzfOt0/wQ4fmDpA9csz6sH+j6
sb6g60v8V/Cz/tfkD8yyP1QvAWH2j/0F3V/2H3T/iZcGifeDeBlo4/0hngq9
vF+8f7DC+/cPI79RJQ==
              "]]}, "Charting`Private`Tag#181"], 
           Annotation[{
             Hue[0.39830392746191023`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1klsow3EUx//hUZLLpOzBw/9BHiwbyYOjhlyi3PKwaBbLC/NEeXArzyyL
udQmpZSUB0XoPKxhzFqG0dRcluv859Gtpf3P+Z+XX7/O7/c553y/J99kaelN
EgShQBCExEnxie2HJTbDfhDMckjoWFo1tWmCcOZNRBTbDc9TG9OXoJXjHZvC
6fG5yDksLiTiFa0rIzm2MR8Q7wUPNXG1OOhm3hN26Z3i79o2yDhvBDPrrr0O
/QQS7xFTvjMOsn72kHj3GB46URfOnyLx7nBnS7dpP7pA+n+L2pe9jdzjENrl
9zfYoKoaLGq+R6p3hWFJ1zpui2CxzA9gucsvdlifmefHr9DfsFt84/8ezLak
dtZURlEjv3dhjzQQNj58cH4XG0ONKmNaDGfk+zpOtKl9/a4YKgoms45OysMo
5+m+C/X8v4z40Mt8yntAqc/9gdKfjvqHUu6/j+YDZb5lmh+qeX4/6QN5rA/r
B4p+rC8o+hL/Ecysv4/8gcla8ofqPUGA/WN/QfGX/QfFf+K9QzfvB/GiUMH7
QzwJZnm/eP/AxPv3D59HSTc=
              "]]}, "Charting`Private`Tag#182"], 
           Annotation[{
             Hue[0.6343719049617107, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kklIglEQxz+KsOgQhR06lSBEhyDKQxA0hwpsOUQEnVpJsYWKoItRtxaI
aAFLo1I6RHkQsksectqILI0ykBZLRRHNpQ5R1/Cb+ebyeMx7v5n5/0cxMN6h
yRIEoUIQhMxJ8Y05nv02eXMAtGKkUS7DtfyjD/C4M5HE4dCb3Zr0Q40YCXxr
6drPkb3ClikTcWyM6RcbinxAvBi2mnWFFeWPzIuiZrDSnL65BhHnjqBiZsg5
f3LMvDAWnJ07ZTsWJF4IMbdy4vbzAokXRLuq88qW94j034+/Jd3t2XvPaBTf
v6BztEVvlQWR6vmwX9nj9a+EsVrkP2F9U0o7eRdl3gPuvhuWjcY4/3ehdanv
ZzaSwCrx/SWaNrTraluK8w5cmC61Ff+lcVW8H6La640aTr9QUjCbdbRQHqQ8
3R0wx/9riQ+bzKe8Cw64PvcHUn8q6h/quH8dzQe9PN82zQ8Onv+B9IEk68P6
gaQf6wuSvsQPg5L1vyd/YIz9oXpRmGL/2F+Q/GX/QfKfeAkI8H4QLwkjvD/E
S0MZ7xfvH0j79w9A8Ue6
              "]]}, "Charting`Private`Tag#183"], 
           Annotation[{
             Hue[0.8704398824614827, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx998FSUXxAURrYWrhdDEKRe0lJrydclM75WPC1Irk5JQPm9G
NEotSpILreQkkXeNCNPKtO1lWeNF7qSlvee85+bp6TzP75zz/5/i3sE2a5Ig
CGWCICROii8syVx2D83I0K+GgmXZ5b91NTJceRPxjh35ReJWYxgq1Yih77gr
13kQhLXVRETRDI5QZkEAiPeG23t+adzzyLwITpxYSv0Lt6DivC94b60fydKf
M0/GlN2KvNM/F/NCqHPMKUsfh0i8IDaJoien24P0/wmN6S1mY88DOtT3fjQd
2iJxawCpng+b51OjDZNhrFD5d7hqy+jD+CvzbvDNtyLPpkX5v4T3w9790akY
GtT3Z7hhKehsHfvgvBsn7YWX388KLqr3HZRcP9XTR5+oKZjMOm5SHi44T3c3
2Pl/LfFhjfmUl+CW63N/oPVXRf3DCvcv0nxg4vnWaX6o4flvSB8wsD6sH2j6
sb6g6Ut8GQZY/2vyBz7ZH6oXASf7x/6C5i/7D5r/xItBgPeDeO/QzvtDPAV0
vF+8f6Dn/fsHxMFFCA==
              "]]}, "Charting`Private`Tag#184"], 
           Annotation[{
             Hue[0.1065078599612832, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx98wN4oUF3OnRWmRNhdK6yjKlYuRK5QstgshKfm4JfKREo3I
R7Eo5evCUEckW828iGUtGa/3NWOocSntPec9N09P53l+55z//+Q2d9S0JAmC
UCAIQuKk+ELF21nfN6pAqxoxdP2E4opJgQtfIt4xO8vobDDKYFYjiqJ+5bG6
X4K52UREMIjTaC18AuK94u/A4Nve4gPzZKxaHpF2IgFQcT4JR3UnnTPNIvOe
0eBvyj/qOmZeGBsrXnY2PT1IvEecio+162wnSP9D2L1w6A6nXqNTfX+Pp/KQ
WOsKItW7wzL7lZTeFkaTyr/BDHPe94TxhXkiHiRn2gIdr/zfi6vWwqI6QxSL
1fenCLe+8eHyD8670Z7TW/l3FsNJ9b6Ol/vn5srtT9QUTGYdlygPWp7ubmjh
/6XEBwvzKe+FNa7P/YHWXwn1D2ncv4PmAwvPN0/zwy7PL5I+4GB9WD/Q9GN9
QdOX+M+Qwvr7yR/YYH+ongw29o/9Bc1f9h80/4kXBQ/vB/HeQc/7Q7wYbPF+
8f7BJ+/fP1RiTQM=
              "]]}, "Charting`Private`Tag#185"], 
           Annotation[{
             Hue[0.34257583746108367`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx5+k5IZLKYq4IBcblrarc6Epi9RoPm7kc7tBrtzIBXIhF9oF
I0ooX0uRj17hhJRlY1iTkoYZttmUEBHtPec9N09P53l+55z//2Q2dhhb4oQQ
uUKI2Enxil/tmKxZCEGrHBEMJL5lpxpC4HLGIoxW/2xPuioIhXKE8GMgqy+/
/gnGx2LxjFrDUf/awwMQ7wkPN0U07/yOeQEU66MN2HEDMs7px7K50qHtOi/z
7rHXmjG2rDpm3i2OvDfvi64V5vmwtmHJ9G1eQ/p/jcHVTpspx4U2+f0VStMz
ldWeS6R6XtzodhZJ5T4skPkXWK1LGdQY/Ug8Nwq1fnLL88j/HVhjb0sr3g2i
Wn5/gNtnmpKkhBfOS6jbs5j09ggOy/cF/K3YMZ8uRlFRMI51nKI8/HGe7hIo
/7XEB4n5lHeAietzf6D0p6H+oYr7t9B8sMnzTdD8MM/zu0kf8LA+rB8o+rG+
oOhL/HvoZ/1PyB9oYn+oXgDi2T/2FxR/2X9Q/CdeCH54P4gXBmV/iBcBL+8X
7x988v79A5qoQ6E=
              "]]}, "Charting`Private`Tag#186"], 
           Annotation[{
             Hue[0.5786438149608557, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kktIQlEQhi8S7VoUBbYKIbAHQVhCkDBE2yCodFMQFEW4SNJaRIu20YMy
kB64aNHGRRRZC0kaKIhMjcywB1KaaV29XQ2EFkKEd+bO5nCYc76Z+f/RjdkG
JjSCIDQLglA+KQoYnZttaUjmYVIJGcPTaB5cyEM4VA4JC+GcydYnQ4cSOSwe
1TUmhyXY3SmHiOKWPhg7FYF4X3iy6fLmrRnmZfBlaUi+X38HBRf6wFLwsNsy
H2deCtMB97W2Psq8JB774EzvuGBeAg3nn/PL8irS/zhW+WPpg9or3FbeP+Nb
9YpXKz8g1YuhU2zrGel/RYPCj+K3Zq2t0pFC4t1h8Wfcbzd+8v8AesbMTVZL
FtuV95f4Z/cbf4MS532YNGUWI04ZN5S7B3W9ozOt+3lUFdSwjnuUBzVPdx8k
+H8X8eGX+ZQPgFqf+wO1v07qH7Lc/xTNBy6ez03zQ4LnvyN9oIL1Yf1A1Y/1
BVVf4qfghvW/JX+gJkT+UL0MPLF/7C+o/rL/oPpPvByUeD+IJ8EX7w/xZHjk
/eL9gwjv3z8QXFGD
              "]]}, "Charting`Private`Tag#187"], 
           Annotation[{
             Hue[0.8147117924606562, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx1+zm9241O6kllouyNfc6ExcaLnycYVdqMmF0m6W0iiTJd+K
RlvcIheGGOkU+Vg2kfK5ZBtv+zKmKYWlvee85+bp6TzP75zz/5/Czt4mk0IQ
BK0gCNmT4gNzWuynd+pP6JIiiYZQVZ89lAK/LxsJ7F8zPEX0KSiXIo677sb+
tO4DFheyEUXlw9BIq/MNiBdBiz3XequOMU9Ep/K4wPrzChLO94KjGvVmvjHI
vDAute8ZivbvmBfEqLfSVWLyMe8Zz09uxG3NGv8PoHk7T3W2eoAO6f09zuwY
ExtfV0j1brDG5vYfph+xTOJfY/FYh659MoTEu8SA/tsMsyL/92Km5/czHY9i
qfT+CJXztvW2qQTnPRgz1U6sW5I4Ld1XcEBVp2hzvaOsoIJ1XKY8yHm6e0Dk
/9XEh8wc8SnvhR+uz/2B3F8F9Q9a7r+b5oN6ns9J88Mgz39J+sAw68P6gawf
6wuyvsQPg4P1vyB/YJz9oXoibLF/7C/I/rL/IPtPvDjs8H4QLwFW3h/iJaGB
94v3D/6aaf/+AQnITeI=
              "]]}, "Charting`Private`Tag#188"], 
           Annotation[{
             Hue[0.05077976996045663, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kstLQlEQxm+XFq0y6h/otYkIooLEFrNz5aYokFY9JSho0YvKSHIR9KBr
WVSIBdWiIoho46ZZBEGUIUpPVJKr1sVn5s4W4Z25szkc5pzfzHzf1AyMdw2L
giA0CIJQPCmymFFuSs9NebCokcah7bKzYGUevI/FSOIcLIohyy+0qpHAwYVG
Y8yUg/29Yij4KdZdRh6yQLxvvOt5rl/9SDEvjjPZUr97VgEV9xjFQkmqakGK
Mk/GFbAGc/Nh5kVQeh37KhgDzPvEqWqz3FGL/D+IRzG9cnV9gbvq+3ecOHnZ
XH/zItV7weUOW4Vz7R1bVH4AtybNBsdxBInnw7ijSe5PxPj/PR6IflG3qGCz
+v4W7YZOqbszyXkPWpfcUrQ3jZJ6P0VdeybUt5NBTUGRdTykPJRznu4emOb/
euKDjfmUvwcX1+f+QOuvjfqHDe5/hOaDJZ7PRfNDF8/vI30gHCV9WD/Q9GN9
QdOX+DI4Wf8n8gf+2B+qFwc7+8f+guYv+w+a/8RLgLYfxEvCPO8P8dIwyvvF
+wc/vH//JplLXA==
              "]]}, "Charting`Private`Tag#189"], 
           Annotation[{
             Hue[0.2868477474602287, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1klsow3EUx/944Ul48LIUpdzK/VLKyYt4UNI8IJGyFOVliQcPc0mxhRQm
RdSWywPJasR5WGI1WpvYMM19s9mW8KLQ/uf8zsuvX+f3+5xzvt+T3tnX2BUr
SVK2JEnRkyKCGR5Fe9nkN6jkCGFlrnr1uv4bzmzRCGLGWoqybv4LiuUIoGG3
Zvm35xMW9dHw42ypW6d0fgDxfGjLGtYoryLMe0HTX2AkHP8OMs72hHdDzbjj
eGXeI7aoew+38x6Yd49tFQk592oX87y4eTI6YBg75f+3OKMvnBuca4AF+b0b
L/tP4+INJ0j1LtGk1UYsqVdYJPOd6NLp3TEmLxLPjjfGjllF9TPSfytaffl7
T4l+LJDfW7B8XVX7kxTkvBmTq1o9mqoQTsv3dRx37LtgKoxCwVjWcYXyMMF5
uptB/K8gPgg+5a1wzPW5PxD9lVD/cMH9d9N8cMDzLdH8sMXz20kfKNogfVg/
EPqxviD0Jf4jNLH+5+QPvLE/VO8Fjtg/9heEv+w/CP+JFwAj7wfxgpDG+0O8
EIj94v2DTN6/fyHQSKU=
              "]]}, "Charting`Private`Tag#190"], 
           Annotation[{
             Hue[0.5229157249600291, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kj1IgmEQx19sCFxqaQgi0IZqiESLHIKLVnMJCwpKCLSaooZaGoqgoIY+
DPpALCqHBmmoIC05woYELa0w+iLjVTFeMYs+pCHC9+695eHhnud3d///afqG
2m0qQRBqBUEonBQ5jD2N3bqv82CXI4sGR+WRZykP4VAhMlgnVGh7oz9gkEPC
pP29Y2z5G9bXCvGKZdrx4oD4CcRL48h8TicGP5iXQnRuq0ssOZBxoQTO6cXS
iSqJeSJ6LLmvrZok815QP2t1dPuemBdH20T/5WE0wv8f8bzN79Wa9mBVfn+H
FvXwSXPnKVK9GN7EjT7Tyg3qZf41PqTuW8unn5F4EbRmW8z7jgTS/yAe20br
t11p1MnvA5jvavIPRiXOe3GyvqdoUZPFBfm+i64/d+x35g0VBVWs4yblYYfz
dPfCFP83Eh++mE/5IPi4PvcHSn8N1D+Euf8Bmg8iPJ+T5gcNzx8hfaDRTPqw
fqDox/qCoi/xRThg/S/IH9hgf6heCs7YP/YXFH/Zf1D8J54EEu8H8TJQzftD
vCwo+8X7B1e8f/9VeUl/
              "]]}, "Charting`Private`Tag#191"], 
           Annotation[{
             Hue[0.7589837024598012, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx19LCrvyMVeS1tRwsczFXJ1ys+RClHbBlXwVJSkpLXtdKCJT
LtDKmPJ1ZbXWaJ0LXGC05isybV7m1TTSktiF9p7znpunp/M8v3PO/38qu4ba
ejSCIBgFQcieFJ84/Ti7VWH4g14lUtjgKxPtsV84D2XjHYM744XWkl8wK5HE
VYduQzz+gZXlbLxh62SVrT/zDcSTsTH8k2M5SjMvgcWZK49c/QUKLvSMZ7rB
4K6YYp6EXmffvdckMy+OU+ZIvn8mzrwYZvTpbvvINf9/QK0gzvc0ISwp7++w
86ndZb31IdW7QTlhcBu1EaxT+JfYsbCG+qUoEi+MTk+wYECSkP6f4GvRXstY
jYwm5f0hnm/mNe3PJzkfwIlY82l5bgqdyn0bx4ZrTxcdH6gqqGEd3ZSHUc7T
PQB2/m8hPoSYT/kTkLg+9wdqf/XUP9i4/36aD154PhfNDxqeP0z6QCnrw/qB
qh/rC6q+xJfAz/pfkD8QZX+oXgLK2D/2F1R/2X9Q/SdeEtZ5P4j3Dge8P8RL
gbpfvH8wx/v3D4MZRFU=
              "]]}, "Charting`Private`Tag#192"], 
           Annotation[{
             Hue[0.9950516799596016, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kklIQmEQx19dlCCIjmEHowSpg6RUpyaKCopIqkMHQRKSCFuOLVRChxYI
QiuyOrSc9OAlCIVgoggJVIQgaDkUymt55UILGRnhm3lz+fiY7/vNzP8/WttY
z2ChIAh6QRDyJ0UaO6xvnvPZHNjlSOKy0VY1UpeDSDgfrxjwNZmrrb9glENC
zARmOv9+YMuTj2d8aSt1T2uyQLwnNHfZLOvnX8wTcXxY0vWpP0DGhROY9b77
vz/TzItjuWti7bhFYt4DdntUkaLmBPPucd65UWHX3fD/O2zc/tSJ7hBsyu+v
cVFfllEf7CHVu0Jn4c/cSTKKtTL/EotHK7Pi/i0SL4apydTtkiGO9P8CI97Q
juvoEQ3y+zPULjj8qi6J80EcaA/UmMQ3XJXvXuytLz0smUyhomAB67hLeejh
PN2DYOH/DcQHDfMpfwEhrs/9gdKfifoHNfc/RPOBg+fbofmhkeePkT7Qz/qw
fqDox/qCoi/x46Bh/aPkDwg+8ofqiTDF/rG/oPjL/oPiP/EkOOX9IN4rKPtD
vCSs8H7x/kEr798/h5RDvw==
              "]]}, "Charting`Private`Tag#193"], 
           Annotation[{
             Hue[0.2311196574594021, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk1LQlEQhm/tWgS1KejbVUkUkhEJyQjRLgpKCleJUbiRcB20yB9gYklZ
F8pNuIlCIoRisIIQNIU+wIoyDVOuWURCIFp4Z+5sDoc555mZ9x2VZWlqoVYQ
BLUgCNWT4gtLzknT8csfLMpRwHjf48m2+w+ikWrksWPEpO4/qoBWDgmzd6FM
RV8G71Y1ctjl+BA0oyUgXhaL6Z+KLvrLvAxa3fMBUSqCjIu8YcOledVx+M28
NF7n5sY85gLzXtHUE2zqqn1nXhLf2sYPfNln/v+EZ6N+7YQYg035fQJT25aa
0xUX17tHr0405gNhHJD5N7i5ofep9xNIvDiaW7ujM8sppP9hfGg0DKkM76iR
31/g7N55va1O4nwQO33a6eTVB67Jdz+6oFe02z9RUbCGddylPDg5T/cgtPP/
YeKDkfmUD8Mt1+f+QOlvkPoHD/dvpflgnefbofmhQaT546QPlFkf1g8U/Vhf
UPQlfhpCrP81+QPN7A/Vy4CN/WN/QfGX/QfFf+JJIPF+EC8PLbw/xCtAjPeL
9w8qvH//ialENA==
              "]]}, "Charting`Private`Tag#194"], 
           Annotation[{
             Hue[0.46718763495917415`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kkEow3EUx39T5IA7QuNCJM0OlLylHCgOKK7U/lFYuUoULbWGdhobc9mB
m8Qah1dG7a9Z+IsmYaaxmaEpRaL93/u/y69f7/f7vPe+36cfsvSYc4QQNUKI
7EnxjmcZ2+hclc4kqZHGhda6TsePMJ2EspHCmYp9h29OmBrVeMGW6UTXwewf
rCxnI4Hn0drxHcsvEO8ZZz+wb/D6G4gXxztZMRVdfIGKCz1iics9FrZ8AvFi
2Hxk7s4PvDMvioUOgzUhJ5h3jwvH1Wv1N1H+f4M6qX3g8VYBp/o+ghLqg2W+
La53iZlVVyQ5cogGla/gviTEjvcKiXeKHfa2UPFhFOm/jJt2Z6A3GMcG9X0A
CyYmr3OPkpz3o9XTv1i/8YpL6n0DH4zlnr2RN9QU1LGO65SHOOfp7od5/t9E
fMhjPuVl8HJ97g+0/ozUP2xz/8M0HyR5PjfND7s8/ynpA6WsD+sHmn6sL2j6
Ej8GRtY/TP5AJftD9eLwxP6xv6D5y/6D5j/xXqCJ94N4KZji/SFeGmy8X7x/
oPD+/QMx30Xa
              "]]}, "Charting`Private`Tag#195"], 
           Annotation[{
             Hue[0.7032556124589746, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kj1IgmEQx18Fl96hoaVo6YMIi0rSQejjpHCIiCAqMFwqFIcoF4sojIgg
oiBosQgsnIKGoCFcvMoWQU3oi8BBU9TSLKJMISh8795bHh7ueX539/9f/dTc
iEUpCIJaEITySfGBBceGKWtSGqxS5LHbU4xVapSGULAcObx4VRnXzxQGrRRZ
1DXcOcxpwbC/V44X7Jvp2tIf/QHxMij6xXB/7heIl8Iaoecre1ECCRdMojPT
/NyuLQDxEnhajHqXTJ9AvDjuGhdsY64c82IoztuHogNJ/h/F6nTLdVXpEVzS
+yc0+7+dqx3I9R5wsNa8eNLkw06Jf4uWWbVr1H2PxIvg+bJ1u1aMI/0P4E1F
3/TEcAo10ns/enoskbeVV857Uby6HG/dfMMd6X6MisbGp/zkO8oKKljHQ8qD
kvN094KK/+uJD27mUz4AIa7P/YHcn476BxP3b6P5oI3nO6D5wc7zR0gf0LI+
rB/I+rG+IOtL/ATI+ofJH1hjf6heCurYP/YXZH/Zf5D9J14W9LwfxMuBj/eH
eHno5f3i/YMf3r9/bWE3yA==
              "]]}, "Charting`Private`Tag#196"], 
           Annotation[{
             Hue[0.9393235899587467, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kt8rg2EUx99tV67EJhdCblYrF5pdiHLepSgXkgvJhdpqGlkLF8ofwIUV
hvKOpCRxofy4WS3Hj9paIVojszLtR9hs4mIY0d5z3nPz9HSe53PO+X5PndXZ
Y1MLgmAQBKF4UryhdsjYIbk14qAcWbT/mOuvBzXixXkxMjgfOL53JdRioxxp
1EVq3KpSteiRivGMjnhoazQtiMR7wkzZb0ul+g+Il8Id/eHE5F4BZNx5Agc8
+6rPrzwQL44zJ35TyccHEO8Rz6y9nV0jOSBeDN/78qt2X4r/R1G6rW6XqqKw
LL+/Q61heurU4ud6N3ggmfdWLAdolPkhXLKVP4QXQ0i8KxxbMzk3u2NI/4Oo
t7RJtnASG+T3Z6jPR57E5hfOe/E7qWmND7/inHzfRr/jaLysP4eKgirWcZ3y
EOA83b1Q4P9NxIda5lM+CNVcn/sDpT8T9Q+z3L+d5oMNnm+V5ocunv+K9IFd
1of1A0U/1hcUfYkfBxfrf0n+gJX9oXop8LF/7C8o/rL/oPhPvDRU8H4QLwML
vD/Ey4KyX7x/oOP9+wfuXz5+
              "]]}, "Charting`Private`Tag#197"], 
           Annotation[{
             Hue[0.17539156745854712`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1klsow3EUx/+2yYsXl+yBl60oe8FckqzzlxeXXKI9WGm1IrxQKHnwIPGg
uZRySS6FTCnytKSjprTahG1KKVszmc3ckzS0/zn/8/Lr1/n9Puec7/doLL0t
HQpBEPIFQUicFC+4Z0s+yXKrxE4pYugJGAfMqyrR7UpEFPd3AqdtapVYLEUE
qzL/Bs3lSnFpMRFhbDTtbsdSFCLxHjDHmjo/YRWYd4/xx7nWn404SDjXHYaL
ht6GHd9AvCBq/F/H6dOfQLwA4qHvpF37CsTz44UimnWrD/P/G6w+zKjt0fph
QXp/jX1j9vlgmRuo3hWOjPbX+NTrqJf4HiyoqwylTFwg8c5Rvak7Uuhukf47
0eidMmyZQlgovXdgRXeoKfsjzHk7Kr2T75b6J5yR7jYcXxlayW15RlnBJNZx
jfIg5+luh18P/S8nPpQyn/JOaOD63B/I/ZVQ/5DH/XfRfNDD8y3T/DDL85+T
PtDM+rB+IOvH+oKsL/GDoGX9z8gfeGd/qN49pEXIP/YXZH/Zf5D9J14EDLwf
xIuCvD/Ei8El7xfvHxzw/v0DY7Y5cQ==
              "]]}, "Charting`Private`Tag#198"], 
           Annotation[{
             Hue[0.4114595449583476, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8ow2EYx3/+bTg4kCVJOTjIWmJlND0/Tv6TEz+5WJNc5qDlgAMHOWAl
hTlMScTkxkiPIlmNFlGK/Nla1mY0B0TRfs/zPpe3t+d9P8/zfL9PUa+tw5os
SVKJJEmJk+IdLdOjrZF0jdynRgwHbfvxuts0+dyXiCgq+lqbvSlNrlAjgmta
py7VkiovLSYijMr3at5acYpMvBccVsbWDc4k5oWw9Xm+fnvpD1ScL4grR1lG
7ewPEC+AvYaapy/9JxDvCfvNU3HZEQfiPaLWBLqGrQj/v8Pg5MGvo+oZFtT3
txiaOTNXZl4C1bvBjs5s18neOJSr/Cv8yNdk2F8vkHh+NF+3D33s3CP992LB
SM5Ay0MQy9T3x1hU3ta16A5z3oOHpxPVu6Wv6FDvG9g8PTdjaHxDoWAS6+ii
PIg83T1wwP9NxIdC5lPeC7lcn/sD0Z+R+ocH7r+f5oMsheZbpvlBM0vz+0kf
iLI+rB8I/VhfEPoSPwDdrP8F+QNu9ofqhUBh/9hfEP6y/yD8J14ENnk/iBeF
Ht4f4sVA7BfvH1h5//4BbcEtDw==
              "]]}, "Charting`Private`Tag#199"], 
           Annotation[{
             Hue[0.6475275224581196, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxVkl0og2EUx59mTLgSKSm5kHaDfDUXOu+WiZILIrWrTST5uHLlI24oablQ
hil3Pmq72J0LnfJRxmuRNqkRec1mMysuUKK957wXzs3T03me3znn/z9ljrHO
fp0QwiiESJ8UKRztPVrYsBqkATWSeBtyGzIKDNK5nI4ENra02odnsqRaNeKY
1z6/MunMlNZW0xHDy0rxY2zWS8SLYn53OOLa0TEvgqHCkmD0REgqTlbweLr6
48X2A8R7xMCB77lY/gTiPaCnS9Zbft+BePfY5uyxeCuSQP/D+C0VrY90KuBS
399geZM9OzgRBKoXwhyrw10/tws1Kv8KM7dLi2f9p0i8C6zquBvyNYSR/vux
0LE8uNinYLX6/hBbbN7x64EY5/fw0+95SuS+4pJ638Hn4f2pKssbin+Rwk3K
g8J5uu/BF/83ER/MzKe8H/K4PvcHWn911D88bVH/gzQf6Hg+N80PEs9/QfqA
wUz6sH6g6cf6gqYv8R9BZv0D5A+csT9ULwJ37B/7C5q/7D9o/hMvDtp+EC8B
Jt4f4iVB2y/WDbT9+wNf0DH3
              "]]}, "Charting`Private`Tag#200"], 
           Annotation[{
             Hue[0.8835954999579201, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxVkk8og3EYx1+TWdsFF05E/iQUmyQOz1tyVkrJn2LLmsgODhykxUkOHGaZ
dlitRC5qqeHw1Iwao83f+XOgMeQ1byJxob3P8x48l1+/nt/v8zzP9/sUm+3t
AxpBECoFQUifFDKuFG6N+6d0olWJFC7XLdjL23TiYSQdErrWpNnQRrZoUuIF
B2smJju2tOKSOx3PuF/aGjRYskTiPWFu9/ppbyCTeUn0uZw9sVCGqOAi9xjq
K7OMVv4C8RJo1nS1XAz9APHu8MmdNxcb+QTi3aI2+DWtb5eB/t+gv1MuqB5O
wqLy/hId+hLbayoOVO8cT0xd87umABgV/gnm28T7U98eEi+KHw2OsbPtK6T/
YcwwtXmdjwmsVd7v4MOMteK96Jnzm+iJNx/nSBLOK/dV7BeDK1VNbyj8Cxm9
lAcz5+m+Cer/RuJDgvmUD8O3kepzf6D2V0/9g4H7t9F8cM3zeWh+cPL8UdIH
AqwP6weqfqwvqPoSPwFW1v+I/IED9ofqJWGV/WN/QfWX/QfVf+K9gLofxJNg
gfeHeCnw8X6xbqDu3x8GIjeS
              "]]}, "Charting`Private`Tag#201"], 
           Annotation[{
             Hue[0.11966347745772055`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxVkt8rg2EUx5+WH5NyZTdKGiFX2FwIdd79Ay7cuqCVRStcSH6lJCkuzFwY
UWM15oLiQrs6fqzWataiZHoTpnnZzLjYCkl7z3kvnJunp/M8n3PO93uM1qGu
Pp0QokEIkT8pMuiWK/cOsUSyqZHGGtfCuHmhRLoI5yOFtfbgcHFSL5nVSKKi
VDxXJIql9bV8vODAZPOgPFMkEU/Br0CrszxYwLwEvrdt/+6f6CQVF37C56PA
7OikYF4cIwcn4cXSHyDeA+7Y2709d1kg3j1O6HfnLY4PoP8yVt364rk5BVzq
+xguG8o+jVYZqN416o57bb3OUzCp/Cv0jI28GabPkHhRDNQ3eD+lGNL/EH53
T82u2uPYpL4/x5usN1cYUzjvR/2m97ExnEKHevfhiqWjs870juJfZNBNeVji
PN39UMD/W4kPl8ynfAiyXJ/7A62/FuofVrj/fpoPBM+3QfODh+ePkj7Qwvqw
fqDpx/qCpi/x4xBl/SPkD6TZH6qXgFf2j/0FzV/2HzT/iZeEF94P4qWgmveH
eGnQ9ot1gy3evz81Vz29
              "]]}, "Charting`Private`Tag#202"], 
           Annotation[{
             Hue[0.3557314549574926, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxVkksoRGEUx69Xxs1mYmOi8cjCowjFQp1bsvFaSEg2lPdCysJjNgql2chC
M8JMUqJRopSisyCajDEYb3kbg8kMEQpp7jl34Wy+vs73/c45//+Jq20trQsU
BCFJEAT/SeFDe6KlI/ZblOrleMapKH3u3Joobdn84UETaKpWtKKUKccT5k8a
FivVYdKI0R8P2Gce2Ek1h0rEc2NEyXV42X4I81z4kt29rV0OkmSc7RZdGSbV
bk0A825w825EPTzzA8S7QnvifkJ18ScQ7xKLzt4Of7degf6foVMMlr7HH8Eg
vz/G94/dlEjnBVC9A2wTekpOVBuQIfP3sFNjbNpZWEbiOTC6S/djWj9E+m/F
9op53br3GtPl96uo729oSRtyc34JTxd7v8otHhyU79N4j3mz8cleFP6FD82U
ByVP9yU44v85xIc+5lPeCs1cn/sDpb8s6h8Kuf9Gmg8GeL5Rmh9iPml+B+kD
56wP6weKfqwvKPoS/wa2WX87+QNe9ofquUDxj/0FxV/2HxT/ifcEBbwfxPPA
GO8P8Z5hgveLdQMb798fE6k67Q==
              "]]}, "Charting`Private`Tag#203"], 
           Annotation[{
             Hue[0.591799432457293, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxVkl0og2EUx9+WtIYrN66UYaWEfIxC502KSMlyLZqPUmTIhZSQWIxczVpt
FOXGha1l+TgkF7TZarWSFds0kzUudmE3m/ae8144N09P53l+55z//5SNTA+M
KgRBqBIEIXdS/OD5S1HbSnOhOCZFEsV+g1edKRC9nlwkcKHctjOlKxAbpPhC
u7baZ2lViZb9XHxiptbu3r5SisSL47JzssYRyWdeDNfWP15vXXmihPO849Dp
2aChS8G8KN4Uttt03VkgXhi97sq49iINxHvDo9Rj3b0qBfQ/hMq+9LHelQCz
9P4Z1zFV5DgIA9UL4rXDvFS56IF6iR9AK6pLIjNOJJ4fO3o0nbN9QaT/D7jj
bwoNzEWwTnp/h4HliV9jb5zzbtwc16f2thK4K91PUJMtzatQf6PwL37QTnmo
4Dzd3bDB/1uID17mU/4BVrk+9wdyf43UP5i4/wmaD3w8n5XmBxPP7yd9oJj1
Yf1A1o/1BVlf4kfBxfo/kT8wzP5QvRgY2T/2F2R/2X+Q/SfeFxzyfhAvAfO8
P8RLAvB+sW5wyfv3B3WzN6A=
              "]]}, "Charting`Private`Tag#204"], 
           Annotation[{
             Hue[0.8278674099570651, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxVkl0og2EUxx+WJBaLWu0Ci4WkZEJcnLfEnRspuZi0EGX5LCKRWtGk3Sgf
S6LEhSIX2o2j5GMZrWi10tqa1mTNIvLRor3nvBfOzdPTeZ7fOef/P3rzYGtP
qhCiTAiRPCnieFI6PmMaVku9csSwOxfGNDVq6cadjCi22FS2bWuWZJTjGWsP
9Y2W7kxpbTUZTxjYmNTbfRkS8SIoNtYzXbF05oVRBdn9xoM0Sca5H3F2f2sn
Ua5iXgi1Re8GzYhgXhALahK6rpIfIF4AF3KulrXN70D/H9A6FSg0XcdgRX7v
Q51/aMDUHgKq58UPv7Fz8c0DVTL/Drd+jy6bRneReB4sbmq4SPHeI/134XS+
dG75CmKl/P4MXfN139VpEc47scO6txMfiKJdvu/hseN1qUL3guJfxHGT8uDk
PN2d0Mb/64gPZ8ynvAsmuD73B0p/1dQ/mLn/PpoPPnk+B80PBp7fQ/qAg/Vh
/UDRj/UFRV/ihyCP9b8lf2CO/aF6Ychg/9hfUPxl/0Hxn3jPUM/7QbwoKPtD
vBiYeb9YNzjl/fsDmWwqWg==
              "]]}, "Charting`Private`Tag#205"], 
           Annotation[{
             Hue[0.06393538745686556, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxVkl0og2EUx19raWmjJjfbFXKB1PLVpJyXRigpbmguWCyyfCTFtuLGV7vZ
uPCRCzc+diM3LkgdJaFGq0mJi8kMbc20WGpKe895L5ybp6fzPL9zzv9/8i2j
HQMKQRCKBUFInxRxrFx9qDZ6s0WrFDEMD/8GFbZs8dqXjiiqWr9KXw41YoUU
EcwzOBZ6XGpxYz0d79iUclrOE1ki8d6wfn9SW/ajYl4YPzWY1O5lihLOF8LR
2sw5XY6Sec94apiCg7oM5j2h3dQ13OxJAfGCGLrYWZye+Qb6/4ixXkf70kgc
1qT399gdsrvMWS9A9e4wd8h30rQdgHKJH8BljcbaWeNG4vnRPHusC/YGkP5f
oW2sUd8884QG6f0ZlnhMuy34yvkjLFwZv3W2RdEt3b3Yr5iYb9B+oPAv4rhF
eejjPN2PoID/G4kPRcyn/BUMcH3uD+T+Kql/uFRT/4M0H+h5vk2aH6w8v5/0
gQTrw/qBrB/rC7K+xH+GE9b/hvwB2R+qF4Yk+8f+guwv+w+y/8SLgI73g3hR
UPL+EC8GEd4v1g2qeP/+AA2kKUA=
              "]]}, "Charting`Private`Tag#206"], 
           Annotation[{
             Hue[0.300003364956666, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJxVkl0og2EUx1+ar/kqF9wpd1zQMuGG82qKKWnuFIWQcrEitNJcuBtqroxo
24WPibjQZD5OUmo1i9RCkjXG2ppJMy58tPec98K5eXo6z/M75/z/p6RX396f
KghCmSAIyZMihusn1nfLfb44IEUUq2fLu43WfPHck4wI7h1uhA8DeaJaijC6
MpWr8e1ccXEhGSG8VZj6MDtHJN4LeuP3NeMpSuYF0bRZOP+7nCFKOM8j+n+2
XvUxBfMC2DR2duDMSmWeH9Fw3drz+Q3Ee8Cp6Eq93pkA+n+Hw0e7jo7RN7BI
72+w6DZxI7iCQPV8OKdt0O3ofFAp8a/Q1en2qNRm5l3gRKAlZI9eIv13Y5tP
oy9I96NKen+KGls87cnwzPl9NFxPljdWRNAs3R34NTRfPKB8ReFfxNBGefjg
PN33YYT/1xIf6phPeTc0c33uD+T+qqh/mO6i/gdpPrDzfEs0P5Ty/BekDxhZ
H9YPZP1YX5D1JX4AtKy/l/yBF/aH6gVhhv1jf0H2l/0H2X/iheGY94N4EXDy
/hAvCvJ+sW6wxvv3B2TYP2Q=
              "]]}, "Charting`Private`Tag#207"], 
           Annotation[{
             Hue[0.5360713424564665, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx99WTAmjlhvLR6MWRT7yUTrvJUlCLnzckGlKXMiFC5OkURRX
Pi8kigtFinahc6FkNbOxZHGxNfnabBK2kGnPOe+5eXo6z/M75/z/J7dnqMWo
kiTJIElS/KR4Q9dH++zktEbuExHCgoN6daJJI5/b4xHEouZnS4daI5eJCOBv
dmjw1JUqryzH4xnlNsu5JjdFJt4TVlVu6mV1MvMesLp28XtpIUkWOPs9Oi7r
J7YuEpjnx96fBpv7UsU8H84UZtboumJAPC+atZ/usZco0P87NKdEJ49G32FJ
vPdg58B+zobxCajeNVZs6Y6tkRsoFfwrvPry32oN28xz4khq455n3In034aO
fP3r75wXS8T7Ezys8/ryKh45b8XB1rK61rQgzov7DmYkNE2tqsKoKBgTEcZ1
ykM65+luhX7+X0V82GU+5W1wxvW5P1D6K6f+IStC/ZtoPijl+dZofhjm+Z2k
D1hYH9YPFP1YX1D0Jb4full/B/kDLvaH6j1ALfvH/oLiL/sPiv/EC8Af7wfx
glDM+0O8ECj7xfsHF7x//5oHNGs=
              "]]}, "Charting`Private`Tag#208"], 
           Annotation[{
             Hue[0.7721393199562385, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx98minzMDRcku/SR5qspF+d1hQslRJFiIhEKyUdSEqMVNz42
K5KSmhJSby5OS6yFJUoJZY2Faaat1NLofc95z83T03me3znn/z8640Bdp0YQ
hBxBEOSTIohDw5q52OxUsUuJAP5Cwaw1qhWvLuX4xJKkvv78da1YrIQfG/S9
u63BFNFqkeMdwx0GfU1xski8N3Rm3rXrEhKZ50OT3bQzNR0vKrjLF3RPdq90
2OOY58Vx82jliSWGeR588vSEfloF5j1j1WD+TF5GBOj/Izqap6TyiRCsKe/v
0dG7er6c+AFU7w4PW9oMjSsPUKTwb7HJWHsmxR4B8a5xr+IorTDXjfTfheGF
0mpD+jPqlfenuOqKd2R9+zgv4XazyXYc9OOSct/Fg60yz2skgKqC0T85vnCT
8rDPebpLsMH/y4gPi8ynvAv8XJ/7A7W/Euof5rn/bpoPkOez0fxwwfNfkz7g
ZH1YP1D1Y31B1Zf4Xhhj/d3kD9ywP1TPB2b2j/0F1V/2H1T/ieeHet4P4n2C
gfeHeAGI8n7x/sEI798/VeUzoA==
              "]]}, "Charting`Private`Tag#209"], 
           Annotation[{
             Hue[0.008207297456067408, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx19SQmKFRLtwJV8RSz4uzrPJR65ErobytVYUucPFpNmdj3Kx
DUVKcsHdLjbqFEljNISE2ZoWbY0aRfLR3nPec/P0dJ7nd875/09B30j7YKIk
SUWSJMVPijfEJnut1aESBjmi6HUd3mgXVeLUE48IDhj3+vPKVKJKjjBaVhPX
N2YyxZI9Hi/YXNNVl6LLEMR7xqvZUbMjJZ15IfyKbas7R1OFjPM8oW7YM9Zh
SWZeEH0dnc/5PUnMC6Bfa9FtpiUwz496/eXFX/M30P97rFh3N06Nv4NNfn+L
vfXqLM1OGKjeNZp2Pj8mS31QKfMvcUKUl2gedoF4Xsyxzr3fdZ8g/XfjwLFN
H2h4xAr5/QEenTfdxrZDnHdi7n6haeIijAvyfQuLlrvbWmJRVBT8/YvHK65R
Hoo5T3cnZPP/GuKDi/mUd0Mr1+f+QOlPQ/3DPPdvpPlgmudboflhiOf3kj5Q
zfqwfqDox/qCoi/xgxBg/c/IHxDsD9ULwQ/7x/6C4i/7D4r/xAuDmfeDeBEw
8P4QLwqnvF+8f6Ds3z+KZzbb
              "]]}, "Charting`Private`Tag#210"], 
           Annotation[{
             Hue[0.24427527495583945`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8og3EYx1/LolbadlsUDjbiIKZceF5/CjloO8mfi6JF8mfmsIOLnFyk
1Pw5uEkOLprG5mlElo0VTSRN00zvbCspsUZ7n+d9Lr9+Pb/f53me7/epHJmy
jqoEQagRBCF/UmRwNuyrznXrxTE5UujwBx/9VXoxFMxHEn9bj6ySVyc2yiGh
qUNq0+p04sZ6Pt4xO6iZmTRqReIlsCjX3u9SlzAvjvNO8e94QCPKuOArfnZq
x8qHi5kXQ8zMW3bL1cx7QVWXlL13FzAvil7318XidBbo/xMamkKTFXNf4JLf
P6C9dMdx3/MBVC+Cd+OFvatDUWiQ+bf4VoeJ9JUfiBfGte5ly83mJdL/AI6e
Gqz7Q89YL78/Q/Pbodo3Eee8B32WpbK9AwlX5PsuTrRk4udSChUFc3/5SOM2
5cHGebp74IT/NxMfaplP+QD0cX3uD5T+zNQ/ZLl/G80HEZ5vi+aHBZ4/TPqA
ifVh/UDRj/UFRV/ix8DL+l+TP/DD/lC9ODjZP/YXFH/Zf1D8J54ERt4P4iXh
m/eHeCmw837x/sEc798/1bY8oQ==
              "]]}, "Charting`Private`Tag#211"], 
           Annotation[{
             Hue[0.4803432524556115, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kt8rg2EUx99WLkjGLmZuiFIsZTE1P+q8XEgkhaSsRO1HSky7kT+AcuOC
MJSryc8rKzKdpKkVmlYrbMsaa9p6hyI3G+095z03T0/neT7nnO/3VE/ODFpU
giDUC4KQPyk+cM9sdwtPGtEqh4QRb1VbzKMR727zkcav0I1k7dWIzXKkcDa5
VGFylYmuzXy8o2eh3X+0XyoSL4mHn+oiW7aEeQk8eNebRjuLRRl3+4r932uZ
OUMh8+KofejpKI8WMC+GF7mt5e5xFfNesM54o+1azQL9D2PtlyN5NvUDG/L7
R+w7/fWGoxJQvRBeDliu3DsxaJL5QdQ+Oz5HNn1AvADqFqema958SP/9GK8M
thjnI2iQ319jg9PmXdUnOH+OraNq5/B6Clfk+z6abSUnE68SKgrm/vKRwV3K
wxjn6X4OjfzfRHyoZT7l/RDi+twfKP0ZqX9o5P7tNB/4eL5tmh8sPH+A9AE9
68P6gaIf6wuKvsSPg471vyd/YIj9oXoJOGb/2F9Q/GX/QfGfeClQ9oN4afjg
/SGeBFHeL94/cPP+/QNDxTty
              "]]}, "Charting`Private`Tag#212"], 
           Annotation[{
             Hue[0.7164112299554404, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx98QudhkboQWccGWyFdyc96yRCKmlQu5UGOkltRaU5J2gRsr
lMmFjytFLTc+kiMu2HyWCE2ZMe9Mszslbdp7zntunp7O8/zOOf//KeqzGs0p
giCUCYKQPCliuH6WCJstOWK/HFG0Z2w6BxpzxMuLZHxhc6nh3HSnEavliKC1
1zjwUagRl9zJCGNFmVs/q8sWiSehS/vUcRTLYl4If3Gs5LpYJcq4izc8tO0H
fhOZzAtirrS1kOdOZ14Ap0f9g560VOa9oEFo6T7djgP992Nwvi1d6vmBRfn9
IxbpfZ7OuhhQvXv0HNvL/x5eoUrm36JxeCi/3eQF4t1g65wzRWo4QfrvxVr1
QZPP7cdK+f0Jqh2qtIXPd87voUs70jXpiKBLvm/gxO7UmvY5ioqC8UQyvnGF
8jDOebrvwQz/ryc+ZDCf8l4o5PrcHyj91VD/YOb+LTQf7PB8yzQ/6Hj+G9IH
JNaH9QNFP9YXFH2JH4QC1v+K/IEz9ofqhSDO/rG/oPjL/oPiP/EiMML7Qbwv
UPaHeFGw8X7x/sEq798/YIw0eg==
              "]]}, "Charting`Private`Tag#213"], 
           Annotation[{
             Hue[0.9524792074552124, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1klsow3EUx/94WDwIy+MeKIlSM3vw5PyU5pZreZDsQQ17oZbkwYvyJA9e
FEtuSUN5cSmKs7YHsVkLM5eVy2ZZY5Zb1DLtf87/vPz6dX6/zznn+z0FPYPt
pnRJkkokSUqdFHEcmPgs/v5Qi145Ypj1Gq7ReNTi1J2KF8wZXbKMdatFhRxR
3PYNd0ZW8oR1NhURbC7cz3i05QriPaPxtLRxeTCHeWGsP1DtHqVlCxnnDmFV
Sd24yZXFvCDay9/nzK0q5j3gsL5PXKxmMO8eLXZJu+xKAv0PoCZgvWpq+IEZ
+f01Tg4l7gy/caB6l1i7oFvPzw6BTuafo+GsQ3T9uYF4Xtz5cl6XzduR/h+j
/+mm4OTwFrXyeyeOBRNm/8YT5/fQloi0CWMUp+T7GjoCm1tJXwwVBf+SqXjD
RcqDk/N034NF/l9JfBhhPuWPwcH1uT9Q+tNT/2Dh/vtpPmjk+eZofpjm+b2k
DxSxPqwfKPqxvqDoS/wgOFl/D/kD1ewP1QtDC/vH/oLiL/sPiv/Ei8Iu7wfx
XkDZH+LFIJP3i/cPzLx//5bGRFo=
              "]]}, "Charting`Private`Tag#214"], 
           Annotation[{
             Hue[0.18854718495498446`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx5+G5mNtmOxSQ0q58LELSs6bciE3UnJJ1pgbCheSciUfuZAr
k8SdpSiEaXViJctsK5Gt5Ws2H9PMhZkbtPec99w8PZ3n+Z1z/v9j7B3qsKiE
EJVCiPRJkUBNR3BjfKJI6pMjjpaAy+DpLJIuPOl4R0/yeWLvUS/VyRFDu91Z
lluhl5Zt6XhF3ezdwUh5oUS8F5zBBl3bUz7zorhVYLK9BbWSjPM8YbfJuN+7
mMe8MCZu1CpnRjbzHrBnJ1MMt2Qy7x4ntW1YMyT4fwgf9Oau+dofWJLfB7DU
cbUpDj+B6l1jMmTwjTVGoFbmX6Jmu/12qtUPxPNj/lnxcarEifTfjcsDgdW5
lyBWy+9dqO1vSo0ORjjvwO/To3NbcwwX5Lsd163GE7UvjoqCv3/p+MA1ysMq
5+nugC/+X098yGI+5d0wzfW5P1D6M1H/UMD9W2k+SPF8KzQ/VPH8ftIH3lgf
1g8U/VhfUPQlfhiSrL+X/AEz+0P1orDL/rG/oPjL/oPiP/FisMn7Qbx38PL+
EC8OZt4v3j/I4f37B8ISNK0=
              "]]}, "Charting`Private`Tag#215"], 
           Annotation[{
             Hue[0.42461516245481334`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kt8rg2EUx18/YknEtlZyg7JE0ssFJee9kOFGSbiU+XWhlH/AJHLpSmjW
ynaxhgs3WK1Du0BGi1Jb2Pxa9K5NyoUxtPec59w8PZ3n+Zxzvt9TNTrTP54r
SVKdJEnZk+Id41tfUX+OUZnQIokn5ppAR8SgXASzkcAu37HbN2ZQmrVQsbvw
3mBy6ZWN9Wy84aJ3yq/fLFeI94qN5r/VhsEy5sWxMx0dftwtVTRc8BnlTEWJ
a6CYeU842VOUd76nY94DRuy2795YPvNi6Jg+6Or7lPj/LVa6Q0sWYxrWtPdh
zNT/LDTPfgDVu8HgUXtsxxoHWeNf45zbY0vrroB4IVQj1vnt6n2k/2eYkmF3
xBTBJu19AK3R2/ol+YXzh+i2eO/WzSquaHcPPvg9jrbTJAoFf/+ykUIn5UHk
6X4ITv7fSnwYYj7lzyDM9bk/EP21UP+wzP1P0Xwg5rPT/FDQQPOHSB+oZX1Y
PxD6sb4g9CX+Ewj9L8kfaGd/qF4cutk/9heEv+w/CP+Jp4LYD+IlwML7Q7wk
iP3i/QOxf/+H6zvx
              "]]}, "Charting`Private`Tag#216"], 
           Annotation[{
             Hue[0.6606831399545854, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx19ETa18bLUQWUkuyGdWsvO64eJ1wyWNJZYLcrkLpdaUxIWP
1HxlJatlKK5W6viIUiOlFAkz5uPVyEdEM+095z03T0/neX7nnP//5Hf0NXcl
CoJQJAhC/KR4xZKbZseIUy/alIhgbfaGVNeqFw8D8XjGKstn0BrSiRVKyDg6
ZFm+zNWJM9PxeMTJwI5vIiNTJN4D9vtyDVl76cwLo8O9vrViThMVXOAWPZ1J
vxfpWuaFsD0mDDdZNMwLovXqSzDak5l3jYM1OfMf9gT+f4Eel3u24O0HXMr7
M1xM8S1NFb4D1TvFv6fqKDjvoVzhn2DjRMv4+eYJEO8Y74oHPvvq15H+H2De
vtW0IJ1hqfJ+F6tebbLx+5bzfoz1eK2SVsYx5e5FqdegcW1HUFUwGovHC7op
Dw2cp7sf/vi/ifhQzHzKH0Aq1+f+QO2vkvqHNu6/m+aDGM83R/PDGs9/TPqA
qg/rB6p+rC+o+hI/BF2s/xH5A6vsD9ULwyD7x/6C6i/7D6r/xJNhjPeDeM9Q
zftDvAiYeb94/6CM9+8fjb026w==
              "]]}, "Charting`Private`Tag#217"], 
           Annotation[{
             Hue[0.8967511174543574, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kksoRGEUxy9Kmcb7mYVnFqzGoyhybmFhg7AYlDIhC+URi0lWyG6aqPFI
HimZLJiFIk2nxmZGd8aUvEIe420MNfJIE809557N19f5vt855/8/mbqe+o5Q
QRByBUEInhTvaKxTT22EJImdcviwYq5MtXSSKDqlYHhRO147MNiaKBbK8YKG
C8msMSWIszPBeMLsIXejbTReJN4jNi/svT5o4ph3jxN9DW2hyzGijJNuMbrY
fmNzRDLPg8LIWYU6TMW8a/zo1ffvRIQz7wq1zukY32cI/z9H3dBq2r79F6bl
96cYVW0puTz2A9U7wvn07xrr7CMUyPwDNFdKFn37IRDPjV+6clVr6hrSfwc2
6WMDprET1Mjvd7HUah7W4S3ntzHgGrnb8j+jUb6bMWs8bz1nx4eKgoG/YLzh
IuUhg/N034Yf/l9CfMhnPuUdIHJ97g+U/oqof9jk/rtoPljh+eZofkjm+d2k
D3SzPqwfKPqxvqDoS3wPKPq7yB9IYX+o3j1Msn/sLyj+sv+g+E+8FzDyfhDP
Cy28P8TzQRXvF+8fGHj//gEseTg6
              "]]}, "Charting`Private`Tag#218"], 
           Annotation[{
             Hue[0.1328190949541863, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx1+S8m3T3CsuhiJfKRfnFSV3Uq7ExcS0XayEixFy5UY0+Zjk
Ize4QRFzc2itDNMiEyEyYx+NtYVC0/ue856bp6fzPL9zzv9/8nSm5s5EQRC0
giBIJ8UHZm7Xz/wM5IpdcoRRZWg5LG7OFV1nUoSwbiKWcHylEcvlCGLkaLjw
IUUjzlul8ONGst3VF80RifeGy+7xDaNVzTwfqocsYw1JKlHGnXnR9L0vZgxm
Mu8ZSzaXHLbVVOY9YfpFtO1+Npl5j1ijr+pI6Unk/3fYdNCZ9T73C3Py+xsM
TC4aT0ZjQPU8uPppqNhb90OZzL/E3a/h9tK4B4jnxlOL1jwRWUH678T4a0Hv
jOMaS+X3dqzsWhtpHfNy3oaG/KOt0G0AJ+X7Ok439he97IRRUfAvLsU7LlMe
pjhPdxvo+X818aGI+ZR3QoDrc3+g9FdB/YOD+++m+WCT51ug+eGT53eTPqBj
fVg/UPRjfUHRl/jPUMz6n5M/YGZ/qJ4PNOwf+wuKv+w/KP4TLwgx3g/ihaCW
94d4Ycjm/eL9gzTev38flj9D
              "]]}, "Charting`Private`Tag#219"], 
           Annotation[{
             Hue[0.36888707245395835`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx9/ko7WV7124W0oWabGkqPNeiGi1UC4ktJAbSSgiJS4wRZKv
XEhZKU1J9F6dvLuQmGQYGY2NDM0oF/LZ3nPec/P0dJ7nd875/4/B1lHdEiMI
glEQhOhJEUFPXmlXybtebFUijN3Dnetbe3rRfRiNF7Ro0hzGCr1YoMQzXlSt
bkp96eLiQjRCmORosg81pInEe8Ryzbhx4DeFeQ/oGYgP1NqSRQV3GESn7kru
yU5kXgAtRtdSBmiZd4tl3rYZqyGBeX4s7ri+SQ/F8H8f3tfZ4wpsPzCvvL/E
r93CydTsD6B65zj6edcubzxBvsL3oDnny1Q/cQHEO0bTYLMlK3ca6f8+7sCp
M6T1okl578KxoMefWRPkvITjhbPbEfkJp5T7Gh7MN8ZeOsOoKvj9F41XXKY8
uDlPdwlG+H8R8aGf+ZTfhxWuz/2B2p+Z+odK7r+N5oM5nm+J5gedTPMfkz7w
xvqwfqDqx/qCqi/xA2Bl/Y/IH5DYH6r3AGfsH/sLqr/sP6j+E+8ZfLwfxHsB
dX+IF4Ze3i/ePzjh/fsH2SEy3w==
              "]]}, "Charting`Private`Tag#220"], 
           Annotation[{
             Hue[0.6049550499537304, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8ow2EYx38ZKSta2G5biklz8O9gp+d3WBE5zEHKYSzEYeSE6xKODjJk
2UX8wmEHIemRpbXM+hXN3wMZYWvmoJQ/037P8z6Xt7fnfT/P83y/T4V7tHMg
T5KkGkmScidFBn/dBTuOfpM8qEUaM4EOf5HdJJ9Fc5HCeNtXvmfPKDdqkcQJ
67HD91QuLy/l4hVn0sGRg5MymXgvaKu2rn64Spn3jNEZs0t/aJA1XDSBfkvr
4F6shHmP6A1veD4u9Mx7wPXGvqPbtULm3eOwe3so0aPj/3c4e+91tlf+waL2
/hp9Xdm6yfAnUL04FplrW8a3ktCg8c+x3hi09OpvgHgq2qpOr2weJ9L/CIYc
WftNdxzrtPchLFanVdWS4Pw+Tlx+L8Q233BOuysYUco2dUoahYI/2Vy8Y4Dy
EOY83fdhjP83Ex90zKd8BHa5PvcHor8m6h/s3P8QzQcGnm+F5geF51dJH5hn
fVg/EPqxviD0Jf4jTLH+MfIHFPaH6j3DGfvH/oLwl/0H4T/xkiD2g3gpuOT9
IV4axH7x/oHYv38hiDdl
              "]]}, "Charting`Private`Tag#221"], 
           Annotation[{
             Hue[0.8410230274535024, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1klsow3EUx/9GyDzMdUqRRLy5LBNy/gpLoVwelJKUS3kQD0sWkcSLS61l
k6JcilaeqIWOUjKhSUgka5rL5u/yIMmt/c/5n5dfv87v9znnfL8npaWrtlUl
CEKmIAiBk+IVUxs1Y/cnWrFNDgnV6/YQ1bJWPDoMhB83vjub2lK1Yq4cPnwe
GOmprIoXZ2yBeMSh8qiLr4w4kXgPOCqlryxtxzDPi5b3hKKS2GhRxh3eobnG
4KzQa5jnwa/xAnVwayTz3OhKtpmq0sKZd4vuwVWz4SCY/1/jb95Zou/mF6zy
+0tsaHzTbTV/ANU7x2pV8U73nB9yZP4pGi2uzUXTFRDPhabSwqQ8+wT/d2KE
qTdozX6GWfL7XTwx7qNR8iDlHThU77VNWp5wSr6voL7M3Ne+IKGi4PdfIF5w
nvKQzXm6O6Cf/+cTH/aYT3knfPZRfe4PlP501D8Mc/8dNB/U8XyzND+08Pwu
0gdC9aQP6weKfqwvKPoS3wM/rP8x+QPT7A/V84KV/WN/QfGX/QfFf+L54JX3
g3h+UPaHeBKE8X7x/kEK798/z9syGg==
              "]]}, "Charting`Private`Tag#222"], 
           Annotation[{
             Hue[0.07709100495333132, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl8oQ3EUx29aQ6HF2FKShz1QSixJ6lwPisfZvHjwMPmTaLIXxYMaxYt4
kJFcXkT2sGZhpY6STKEhk1r+dNfCZhNSoqbdc+55+fXr/H6fc873eyrsjvae
LEEQKgVByJwU79ixuR76aTSKvUokcWLKnjtcYBTPzzKRwPwvhxSfMYh1SsQx
8PY55PWWiMtLmXhBh37RZ5wuFon3jB+e6i6nQc+8GB4fDhjDfYWigjuLYm25
tjTq0jFPRn/MPVuSymPeE7qcD90jUg7zHnG/7MBXZNbw/wi2Lgy7gvNpcCvv
71C2QFL6/AaqF8bgxZjfMv0GtQr/Gnea7wfdkQgQL4S/G7LOpJf4/yleDrSY
Pdk3WKO8P0Kru9NWiTJSPoBVV9J208Qrzin3LRzX7O1qV5OoKviXzkQK1ygP
o5ynewBM/L+B+NDGfMqfAnJ97g/U/szUP5xw//00H9zyfCs0PyR4/hDpAzbW
h/UDVT/WF1R9iS+Dqv8F+QP17A/Vi0GQ/WN/QfWX/QfVf+LFQd0P4iUgj/eH
eEmY5P3i/QMr798/0qk4pw==
              "]]}, "Charting`Private`Tag#223"], 
           Annotation[{
             Hue[0.31315898245310336`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl8oQ3EUx294UYaYNnsQL6uRPyFT1LlP3kieCMWK/GmpefIk3hCNhVlb
eBDzorxoUUd5Wm1aiMQWrsY23YlGkqbdc+55+fXr/H6fc873eyosE11DWYIg
mARByJwU76jf1rV2berFYSVkDDl2nFU2vRgMZOINA96WyauETmxQIoER/VOp
u0AnujYyEcPBmfBi8qlEJN4rzofX+8xWLfOi2N3uSO8dFYkKLvCM5XmeeF6w
kHkSfp3eWFM2DfMecdReXmvQ5jLvAd1LqVjZRg7/v8c+GOjvKBNEp/L+Fj1T
RnN8+huo3jWeVNqE42EZ6hX+Je7UZO8fVEeAeCH80chNc/m7QP/9mJ79NBWP
XWGd8v4MH7+1lt9lCSnvQ9dHW09kPI525e7F1ZfOBckpo6rgbzoTSdyiPKxx
nu4+WOH/zcSHO+ZT3g8Jrs/9gdpfI/UPh9z/CM0Hfp7PTfPDHs8fIn1ggPVh
/UDVj/UFVV/iS/DH+p+TP2Bkf6heFHrZP/YXVH/Zf1D9J14CJN4P4r2Bn/eH
eDJc8H7x/oGB9+8fanE2wQ==
              "]]}, "Charting`Private`Tag#224"], 
           Annotation[{
             Hue[0.5492269599528754, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8ow2EYx3+xHcQOQ9u4yJx2kz+Fmue3VpojErWiaIuUJcLByQ6uJoSE
KHJRDg6oPTV/p80mElKbTQubbXLwr9B+z/N7Lm9vz/t+nuf5fp/SLkezLUsQ
BIMgCJmTIo15hpUm769OtEuRxPft1WHVhU70+zKRwDf/eMu3RSdWShHHkvq9
opderbgwn4lnjBxp1qy1GpF4T5jW7t8E3IXMi6H5tG1kIbtAlHC+Rww7B6wb
+WrmRdHc4XH1pVXMe8AT16xb48xhXhhnAmVg+lLw/3tUrB2rpxyCOCe9v8W9
Rs9Et/ITqN41Bs2K9da6FFRI/Ev07XyV2/pDQLwgxoyFH6PVW0D/vTi0rGzU
X11iufT+AN/vXNFfexQpv4tHxYP+sfYXnJTum2hasuQK00mUFfz5y0QKVygP
Rs7TfRcO+X8N8eGV+ZT3QifX5/5A7q+K+oc77r+H5oMQz7dI88MZzx8kfSCX
9WH9QNaP9QVZX+JHwcL6n5M/EGF/qF4MGtg/9hdkf9l/kP0nXhz0vB/ES0Ca
94d4SZD3i/cPVLx//0YaNdg=
              "]]}, "Charting`Private`Tag#225"], 
           Annotation[{
             Hue[0.7852949374527043, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kksohFEUxz8KiUjjNTKJhTzKezE0OZ8SyTOmJCUNPrKRjdR4FMmCYjdm
GmLJjrIgOiFpakhNmQaL0Uge02dqlNeC5jvnns3tdu79nXP+/5NrGescipYk
qVCSpMhJEcL86dy56h69rGihYvtlS1uoSC9fuiMRROvGj824lSlXavGGrV2L
/gnMkB32SLzgftb4c81Suky8Z1R2J3eyE9OY94QZTZbl5WadrOHcj+hR18M2
cwrzAti/vzHaOJzEvAeM7c4sNwXjmefHYp1j22yO4f/3+D3grlo5kuQ17b0P
e02+BO/8F1C9G8w7mfpUokJQofE9eNhaZzC0+4F41/iafJoaN7MH9N+FH8cL
amqDB8u092e4NVISrq8NIOUP8N75585peMVV7b6Ns3cXpX0rKgoFf/8i8Y6b
lAcr5+l+AF7+byQ+2JlPeRf4uT73B6K/Kuofzrn/EZoP8nk+J80PCs9/TfpA
1CDpw/qB0I/1BaEv8QOgsP5X5A/csj9U7wmEf+wvCH/ZfxD+E+8NOng/iBcE
sT/EU0HsF+8fFPD+/QPqByx3
              "]]}, "Charting`Private`Tag#226"], 
           Annotation[{
             Hue[0.02136291495247633, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kksohFEUxz80FhbyCDMLZSKPnTCN3bkrOylN0lh4RRbEktVEFDYjK4YF
JTWmEEmzmM6UQWoGUYzi8/gk8zAzCyGD0XznfGdzu517f+ec//8Ye4Zb+zIl
SaqRJCl9UiTwY6/dbNs0iH41Yph09nq3bQYR8KcjikdBw9Tgu17UqxHBn2OB
ZXl64VhMRwjr7QelQ8FiQbxXfFqqsKYsRcx7Qb9FyD32QqHi/M/Ya4i4fPP5
zFPwbTKUZb3OZd4jyjXj710tOcx7QM+q2Wja0PH/W9wxfTZX6TLEgvr+Bkf7
HfsFyS+gelcYLIg3hTsTUKfyL3HstbKtQ34A4p1jdbFpLbC1B/T/BL1RX1u5
9wJr1fcHuOnp9t2VKEh5Nyqpv93ThjDOqXcnTmePXKdmY6gpmEylI44rlIdJ
ztPdDTL/byQ+rDOf8ifg4vrcH2j9NVD/MMH9D9B8cM/zLdP8MMPzn5M+sM/6
sH6g6cf6gqYv8RWIs/6n5A/0sT9U7wXO2D/2FzR/2X/Q/CdeBH55P4gXhUPe
H+LF4Jv3i/cPvnj//gHfC0CB
              "]]}, "Charting`Private`Tag#227"], 
           Annotation[{
             Hue[0.25743089245224837`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx19fNy5Iplm5oFwgK20rbnTetis3LnajLJRYUiZK3CyhcSHs
Qs0W+cgNLVfUFnUUYhkWNVu58Dlfaz6WaVNo7znvuXl6Os/zO+f8/6esvdfY
mSkIQqUgCOmT4h3HHipuh35VolmKGDqs7j71mUo88acjil+Nec0DepWoleIV
P0qMn4emYtHlTMczanTD4YtSpUi8J7TVblebnEXMi2BbeGc986xQlHD+e8zX
aJOKkwLm3eGxOVs5KOYz7wYnE1XBFncu867RsLjs3k3l8P8rRItlpb4hQ5yT
3ofxyGswPXYngeoFMR6cbZ3xvING4l+gbbJsdbPjBogXQHX5bsq/4QH670Pr
j3FiVH+ONdL7Pcwy9yyE4rdIeS82TV/228tf0C7d19DjcB1ExmMoK5j6S8cb
LlEetjhPdy8Y+X8d8eG7k/iU94GZ63N/IPeno/5hivvvovngh+ebp/khxPMH
SB/YZ31YP5D1Y31B1pf4dxBg/U/JH1CwP1QvArJ/7C/I/rL/IPtPvFeQ94N4
UUjw/hAvBk7eL94/GOH9+we9bzyu
              "]]}, "Charting`Private`Tag#228"], 
           Annotation[{
             Hue[0.49349886995207726`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx19WiKKWNZaSK+zCtC0ZF+ct+UqRuZALFxhh8nHhgluJzIWv
C+Q7xSh3kqhzwYUJGzImymwtH2uMG6Ro7znvuXl6Os/zO+f8/yejscvcHC0I
QrYgCJGT4h3bw6q42HKN2CJFCDcmalNKUzXi6UkkgrjQ5Ks32lJFgxSvqN6v
26pcSRFnZyLxjIeFD1Nmi1ok3hPqvhp0Ko+KeQG0Ho/fmOOTRQl34kelR+vu
USiZ58PMPmda70oS87yoL+9VJioSmPeA/UObndfFMfz/DkfzysSd4ShxWnrv
QafRvp11+Q1Uz43F1VU5hoQw6CX+Jd76bcFPrxeI50Jnes3vVd8e0H8Hmj7y
Ciyn55grvT/A9aO286KLR6T8LppKRmxW1QuOSXc7DnasLicPhFBW8OcvEm+4
RHkY4Dzdd0HP//OJD/PMp7wDtFyf+wO5PyP1D37uv5Xmgwqeb47mh3ue30X6
wCTrw/qBrB/rC7K+xPeBlvU/I39Azf5QvQB0s3/sL8j+sv8g+0+8V5D3g3hB
WOT9IV4I1ni/eP/Ayvv3D1PSKt4=
              "]]}, "Charting`Private`Tag#229"], 
           Annotation[{
             Hue[0.7295668474518493, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx18uJqFJy9iFomRqJBu5UOclN66UGSISkfJd7pa40cRaEoVc
yJ0LwtLakpNExiwipVzgZcbWfCaJaO8577l5ejrP8zvn/P8ns7Wvuj1WEIRc
QRCiJ8ULTtoCVYkOndghRwTNDY6x6yadeOyLRhgPguchuz9dNMoRwjunzjAn
pYnzc9F4xB+pweVf0orEC+L0W365RpPKvABuuXpiSss0oozz3eGHZPftFaUw
T8Icq74571fNvBs8spnbqswJzLvGyoHHjcYJFf+/woz1rHjrbow4K7+/xPf1
mdEV4zdQvQv0/HWpNuteoVDmn+GgNnn1wXILxDvB4qFarV+9DfTfiyNH/Yef
LadYIL/fxfTImsfgvEXKu3HAlK3uiHvCSfm+jDX1FZ/jwxFUFPz+i8YzLlIe
LJynuxu6+X8J8SGJ+ZT3Qi/X5/5A6c9E/cMw999J88EOz7dA84OwQfOfkD6g
Z31YP1D0Y31B0Zf4EmSz/n7yB77YH6oXgG32j/0FxV/2HxT/iReCe94P4oVh
n/eHeBGo4f3i/YMp3r9/G4o0hA==
              "]]}, "Charting`Private`Tag#230"], 
           Annotation[{
             Hue[0.9656348249516213, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx9+tKPlIGrILi1rhxsc0SjmvS1woV3bhZgwXPpJyY8mNO0op
GVs+2sq4lLKis1LysWmlfA2xydfmNTfYMrT3nPfcPD2d5/mdc/7/U2Ieareo
BUEoFwQhdVLEMOzrmx7wa8UeOSS8mNV7b+1a0e9LRRQ7dEfj3Vla0SBHBNeN
js1pXZG4YEvFC0oN4krldaFIvGfctRlKm1oKmPeI1qfmsbURjSjjfA+odbmS
P115zAvj1b5T1ViWy7x7nKy4yVY7Mpl3hxmDvfHq43T+f40H+Wk7w3GVOC+/
v8SZ0V9b21QCqN4ZRlatzk/HB9TI/FOUgnqN2RsC4gUwpz95eV7nBfp/iJou
X4klGcAq+f0efoXcW0tzIaS8BzuN5sXJxAvOyHc3bte+VbVaJVQUTPyl4h2X
KQ9bnKe7B0z8v5748Mp8yh/Cj5nqc3+g9FdL/cM3999H80GM57PT/ODg+QOk
D5ywPqwfKPqxvqDoS/wwBFn/E/IHitkfqvcIE+wf+wuKv+w/KP4TLwIbvB/E
i4KJ94d4Eij7xfsHyv79AxBvPCo=
              "]]}, "Charting`Private`Tag#231"], 
           Annotation[{
             Hue[0.20170280245145022`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx19jzTbaJg1bLe5YifkoHxfnVdyxC0Wu1BTJzUTS4kaNS9z5
SGILk3KhJLk4SZIaJpkwNZsWbV6UFBdo7znvuXl6Os/zO+f8/6ekx93eqxIE
oUwQhPRJ8Y7TWx1Bk8Yq9skhoW/E/VEatohnwXSkUH/zeeBrtojVciRx4Nez
nt9ZJC4upOMFXw1zu93GQpF4z6iuOBmaGjMzL4HLO7ku72q+KOOCT1i+12BX
T+cxL47XhgxTsdPIvEcMZN1L2VE986Ko9U9kNKk1/D+C/VHv76RdJc7L72/x
05z5mIz8ANULo3+0ESIPH1Al868w5rJp60viQLwQ2hz+tpbWQ6D/p+gUcgNh
Xwgr5fdHGL38sgbGY0j5fTzWDXddSC84K983MWe7cbXTI6Gi4PdfOt5whfKg
5zzd90H5X0d8uGI+5U+hlutzf6D0V0P9Q4r776f5YIPnW6L5QV1A84dIHxhk
fVg/UPRjfUHRl/hxuGP9z8kfcLA/VC8BPvaP/QXFX/YfFP+JlwQ37wfxUqDj
/SGeBGu8X7x/MMP79w/Vayld
              "]]}, "Charting`Private`Tag#232"], 
           Annotation[{
             Hue[0.43777077995122227`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8ow2EYx3+t1gglabZxETuYFOaAy/M7iNSIHRTHaXLbHMwOyoFotBon
5KCl/Dm4rLTJempE02ha0RqFITNmrZB2oP2e5/dc3t6e9/08z/P9PrUWm9mq
EAShQRCEwkmRxcRH/8hjZ7U4JkUGd0oM7p3iavEiUoh31H95plumdKJRijRu
/ppcmgWtuL5WiBTeufSjPaARifeKy96y0+i2mnkv6NdOrwfPK0UJF3lC9Uwk
cOGrYF4S5yYtz032cuY9YL2yb763ppR595guiscmOlT8/xbNK43WrSGFuCq9
j+PJkW/Sos8D1btG74Nj2VSVg1aJH8O384PubmcSiBdFlTdhCHWFgP6HMWd2
Gm2DUWyW3h+j+0wlDlgfkfIBPFzMf/c8pdAj3XdxSWl37jsyKCv481eIT9yk
PCxynu4B8PP/duLDLPMpH4Ybrs/9gdxfG/UPWe5/nOaDXZ5vg+aHK54/SvrA
MOvD+oGsH+sLsr7ET4KL9b8kf0DH/lC9Fwiyf+wvyP6y/yD7T7w0bPF+EO8d
6nh/iJeBPd4v3j+45f37BxiEMok=
              "]]}, "Charting`Private`Tag#233"], 
           Annotation[{
             Hue[0.6738387574509943, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kl0og2EUx19qiUZCMkoUyYiFYm7OWy40k8+WckeN15XEndzuhuRKCBEX
PtYIJSmHlhizTTKRC2wta2vzeeMj2nvOe26ens7z/M45///J7+5vM8cLglAs
CELspHhB+/yH+0zKEXvkiOCowWI0VOeIF85YhLHz9dD7s5QtVsoRwsawUW3Z
0ogz07EIose0UnojZYnEe0bV0+5yijuTeQEcsEu+umiGKOOcfsx1lR3VX6cx
z4dlhXVJneOpzHvE5HJ/nLVVzbwH9Ku7zjd6E/j/Pa4faIb3R+LFKfn9LZZ0
TFknzd9A9by4rRX8uoY3qJD5V1hk05p7j31APA/Oba+J4Tw70H8HmopPvpoS
PaiT39txIJTet9jyhJTfw4LLWtv7XRAn5Psqqn7fT9uHIqgo+PkXiyguUB7i
OE/3Pcjl/zXEB4n5lHeAnutzf6D0V0X9g477l2g+2OH5Zml+0PP8HtIHNlkf
1g8U/VhfUPQlvg/KWX8X+QN57A/VC8Ag+8f+guIv+w+K/8QLQTPvB/HCoOwP
8SIwxvvF+wfK/v0DxOc1fA==
              "]]}, "Charting`Private`Tag#234"], 
           Annotation[{
             Hue[0.9099067349508232, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8ow2EYx39NsYP8WRFWatjkNuwgB8/v4E/JydFhIdaSWik7KCVRDqsp
FNoadvDnpHYah0d2wNpsDYtyGBZbbNiiRov2e57fc3l7e9738zzP9/toRi2D
4wpBEFoEQSicFB+YtpbVepfVokmKNPod3YacUS0GA4V4w3DTgjbrrxPbpXjF
7VxeNXBbK25uFCKJFSOGw7ytRiReApeuf1b1n9XMe0ZbpDWiLK8SJVwgjpoe
q9KUUTHvCR39npX1vQrmPeDNy2Sveq6UeTEccM87E/YS/n+PZ+b4+bFLIa5L
7+9w4ihbb3H+AtWLosa4UT1tzUCbxL9Cz8FJYlYZB+KFcce3ZJ+M+YD+X2BD
c1Gldi2Eeum9D4PBmZC76xEp78Xh4rHOaCSJy9J9Hx3q1GLfVBplBb/+CvGO
W5QHOU93Lwzx/w7iwynzKX8B3zqqz/2B3J+B+gcv92+m+UDH8zlofpjh+cOk
D4RZH9YPZP1YX5D1Jf4TuFj/S/IHGtkfqvcMdvaP/QXZX/YfZP+J9wq7vB/E
e4NL3h/ipSHA+8X7Bynev3+fUDpC
              "]]}, "Charting`Private`Tag#235"], 
           Annotation[{
             Hue[0.14597471245059523`, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kt0rw2EUx38puSDm3SxFCnNDXmoX6vz2B1AkN8pbkUK0CykuJKHdEBcz
pkRiXhK5mbcjpNgwZMW8W7KskZTFBe13znNunp7O83zOOd/vSatrLasPkSRJ
K0lS8KT4QGPLQefEqkZuUMKPd8memblujXzsCIYPO+L2o0J9yXK+Em+4VRG9
URlQy2PmYHhxanhnaXEhSSbeK673r6dqIxOZ94J9+q7bP228rOAcHjwr16lS
wmOZ94yGkpj0+20V8x6xUJ0R6J2NYN4Djq+U1kashvH/G3SFzl+bNkPkUeX9
FSYUbK9dOn6B6rlwevluNszyCXkK/wKPrPbiVr0HiOfEn2Zr03fPPtD/QxzJ
MFXPZJ9irvJ+D3f1g+aqnCekvA3rDZnuT7sXh5S7FYva3T3GNj8KBb/+gvGO
k5QHkae7Dar5v474sMl8yh9CDdfn/kD0V0D9g5P7b6T5YJ7ns9D8kMXzO0kf
uGF9WD8Q+rG+IPQl/jMI/U/IHzhnf6jeCxjZP/YXhL/sPwj/ifcGO7wfxPOB
2B/i+UHsF+8fDPD+/QOgSDey
              "]]}, "Charting`Private`Tag#236"], 
           Annotation[{
             Hue[0.3820426899503673, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kktIQlEQhi9CZGAPkiyyB0VCRYtei4hg7sIWhbUoKMKEMhKJoCBoU6uC
NkG0CcokbFeLNhGEEY1kL8HsYQ8NF2mhiWIPly0K78ydzeEw53wz8/9TZZ7q
G1cIglAnCELmpPjC0NP31oRPK1qkSKHJGTZ227XitTcTSdxuml3RZWvFFikS
uHhgMO8Uloq2jUzEcVn3qAqclYjE+8D2wdhLUlfMvCie7jeOVohFooTzvqM1
rdWMVaqZ94ZF1vpEzV0B88IoKBULwUsV814xJ+9+LdeXzf9DeOUa7tQ/KMR1
6X0QGzb79w7Tv0D1ntCorz0OHv1As8T341BemVo3/Q7Eu8XKfK/NoDwH+u/B
mKsnq8vvw0bpvRsj+deB5+oIUt6JA5bJPsNFHFel+y7OV3XOlE+lUFYw/ZeJ
T3RQHuY4T3cn9PL/NuLDM/Mp74ETrs/9gdxfK/UPJu7fSvPBCM9np/mhg+e/
JX3ghvVh/UDWj/UFWV/iv4GG9feRP2Bhf6heFNzsH/sLsr/sP8j+Ey8BS7wf
xEuCg/eHeCkw8n7x/kGA9+8fzMIpqg==
              "]]}, "Charting`Private`Tag#237"], 
           Annotation[{
             Hue[0.6181106674501393, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kktIQlEQhi9BtMhF9KDHbVG4kFaFBRpEczcKLnPRRiqS3tBLqoVroajA
yMCSiGoRhLWIoBCCIaNFUFoJUWCYXdFSs9eiTVB4Z+5sDoc555uZ/596+7i1
v0AQhAZBEPInxQeawwPuioQoDSiRQ5O1cCpyIEpXl/nIovgY/rTUilKzEhn0
tPv8Ol2N5FvLxysu+Lrj0/dVEvFe0F5X3OcwVjIvia7U0bato0JScJcJnOwK
VDU1ljFPxt6/vUN7rIR5cezUhURNXMO8J5zat+jichH/j+LJG/iPkwXSqvL+
AWcGb3YKS3+B6t1h60avNnb7BXqFH8H0fjS4uJIA4l1jj2F+1DBxDvT/ArUj
No/eHcIm5f0Zuracs+XVz0j5AHqdbXLi9BWXlPsupkbH0sJYDlUFv//y8Y6b
lAeZ83QPwDL/NxIfnMyn/AX8DFN97g/U/lqof8hy/0M0HwDPt07zg4vnvyZ9
IMj6sH6g6sf6gqov8WWws/4h8gcc7A/VS8Ic+8f+guov+w+q/8TLgJf3g3hZ
qOH9IV4OzLxfvH9g4v37BznxNGo=
              "]]}, "Charting`Private`Tag#238"], 
           Annotation[{
             Hue[0.8541786449499682, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw1kk8ow2EYx3+NIjHamLGDdhJSGit/Ds/v4uaw5IYdFHGw1RxccCFK0iL/
hiy5KEkcRPEkJMVMllhTm83aZo02ByS03/P8nsvb2/O+n+d5vt9H32Vt7VYI
glAhCEL6pHhHdVbH2VxKJ/ZIkUDN1KGt6UQnXl+lI47O68mXviqdWCvFKx6Z
K0dvjaWiYykdUaweW7eOhLUi8SJoesq07DYXMy+MyTaLZ6ezSJRwVyHcGrzw
DjeqmRfEyKzSNxMtYF4AXfNwo0rlMs+Pxo/VgZFUFv/3YUZsHmMphbgovX/E
X79+Y6/8B6jePRraPJ3KUBIMEv8OlfkPXwvbISCeG72BEs/04TnQ/0tcTsx+
D5ldWCO9P0W7Y39cq3pGyh/g6ZTfdHwcRbt030RTTlm7sT+BsoLJv3S8oZPy
0MJ5uh/AEf+vJz5MMJ/yl2Dj+twfyP3VUf+g4f57aT5o4PlWaH7IC9D8btIH
slkf1g9k/VhfkPUlfhDirL+L/IFt9ofqheGT/WN/QfaX/QfZf+K9AvJ+EC8O
a7w/xEuAlveL9w8Kef/+ASb6PhA=
              "]]}, "Charting`Private`Tag#239"], 
           Annotation[{
             Hue[0.09024662244974024, 0.6, 0.6], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Line[CompressedData["
1:eJw9kl0og2EUx1+7cYEiZLYrljIlmtGKnNfNRC0lF0oiIcnHhd1tZUW5QImU
jxXlYik3uxzaSZrQLCIfJR/7Ym29w4WSifae8zo3T0/neX7nnP//lPSNtw+o
BEHQC4KQPineELouSiMprTgoh4TlBVaz/VQrnvnTkUBnm8k6adSKNXLE0Xe0
U7LZqBHXVtMRQxE7qhKSWiTeKy5b3r0uSxHzori+1KcuHigUZZw/jHWu5Uhz
Uz7zQlisOeh2J3OZ94zm/qAt+pPNvCcss+9aHlOZ/P8ehz+nWm6/VeKK/P4O
db/uPI8xBVTvGucrwxu90gcYZP4lzmXpRhu8YSDeOUKnbaz2xQf0/wRnMm4c
9U0BrJbfH+JsxZczmhNEyntw+qrq4W4/hgvyfRtbddaivREJ/xX8TUcSNykP
Zs7T3QOT/N9EfHAwn/In0MP1uT9Q+jNS/7DI/Q/RfLDE8zlpfjDw/OekD0yw
PqwfKPqxvqDoS/wQaFj/APkDJvaH6kVhi/1jf0Hxl/0HxX/ixeGY94N4CVD2
h3gS6Hm/WD1o5P37A9DBNZg=
              "]]}, "Charting`Private`Tag#240"]}}, <|
         "HighlightElements" -> <|
           "Label" -> {"XYLabel"}, "Ball" -> {"IndicatedBall"}|>, 
          "LayoutOptions" -> <|
           "PanelPlotLayout" -> <||>, "PlotRange" -> {{-1., 1.}, {-3., 8.}}, 
            "Frame" -> {{False, False}, {False, False}}, 
            "AxesOrigin" -> {0, 0}, "ImageSize" -> {576, 576/GoldenRatio}, 
            "Axes" -> {True, True}, "LabelStyle" -> {}, "AspectRatio" -> 
            GoldenRatio^(-1), "DefaultStyle" -> {
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]], 
              Directive[
               PointSize[
                Rational[1, 360]], 
               AbsoluteThickness[2], 
               Opacity[0.4], 
               RGBColor[0, 0, 1]]}, 
            "HighlightLabelingFunctions" -> <|"CoordinatesToolOptions" -> ({
                (Identity[#]& )[
                 Part[#, 1]], 
                (Identity[#]& )[
                 Part[#, 2]]}& ), 
              "ScalingFunctions" -> {{Identity, Identity}, {
                Identity, Identity}}|>, "Primitives" -> {}, "GCFlag" -> 
            False|>, 
          "Meta" -> <|
           "DefaultHighlight" -> {"Dynamic", None}, "Index" -> {}, "Function" -> 
            ListPlot, "GroupHighlight" -> False|>|>]]& )[<|
        "HighlightElements" -> <|
          "Label" -> {"XYLabel"}, "Ball" -> {"IndicatedBall"}|>, 
         "LayoutOptions" -> <|
          "PanelPlotLayout" -> <||>, "PlotRange" -> {{-1., 1.}, {-3., 8.}}, 
           "Frame" -> {{False, False}, {False, False}}, 
           "AxesOrigin" -> {0, 0}, "ImageSize" -> {576, 576/GoldenRatio}, 
           "Axes" -> {True, True}, "LabelStyle" -> {}, "AspectRatio" -> 
           GoldenRatio^(-1), "DefaultStyle" -> {
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]], 
             Directive[
              PointSize[
               Rational[1, 360]], 
              AbsoluteThickness[2], 
              Opacity[0.4], 
              RGBColor[0, 0, 1]]}, 
           "HighlightLabelingFunctions" -> <|"CoordinatesToolOptions" -> ({
               (Identity[#]& )[
                Part[#, 1]], 
               (Identity[#]& )[
                Part[#, 2]]}& ), 
             "ScalingFunctions" -> {{Identity, Identity}, {
               Identity, Identity}}|>, "Primitives" -> {}, "GCFlag" -> 
           False|>, 
         "Meta" -> <|
          "DefaultHighlight" -> {"Dynamic", None}, "Index" -> {}, "Function" -> 
           ListPlot, "GroupHighlight" -> False|>|>],
       ImageSizeCache->{{4.503599627370496*^15, -4.503599627370496*^15}, {
        4.503599627370496*^15, -4.503599627370496*^15}}],
      Selectable->False]},
    Annotation[{{{}, {}, 
       Annotation[{
         Hue[0.67, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTsKwkAQhhcbHwkBCR7AdHaiFnZzB48gKHZexVLFwtYjpFrBKhAlIAiC
hRIJhoSQI0h2NgM708z+zMw3j+3P17NFQwgxEEJUHq2UHXycl8oKaWt9DSvL
paX1WFlGer+rLJWe1uh+0jV4iexqrXDhl/FixvtIx+C9KY71L9nSeqvyn6Sx
34P2GSn+nerRRbQf1geUP1T5F9IY90lvlD4xnhBNrY8YB9vQPrS1niIfLCMe
AJuP6ic4P9T9V7gf8Q64P9VHeB/K1/cDdl9wDH5M+Tf8H+qP/RLomf8LrsFL
wTN4GePlbP6C7VtC/X9/uhK4Uw==
          "]]}, "Charting`Private`Tag#1"], 
       Annotation[{
         Hue[0.9060679774997897, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkc8KQUEUxicb/0t5AFnaCQu78w4eQZGdV7FEFrYeweooK4VuKaUsiEQk
j6A73/jqOJu5v76Z3zkzt9zutzoJ51zFORevqI+m8LHo+nprJvBmHddL04Hr
vp7Mx6O4HloKjOWuReO7aSGw162vmjW+C/3wnTVvfCfOh/NH8tDvP2jS9Ntz
vpr377gfS8Qc51fkqt+/5DzI5+SB5xn594K//lPkkjI8Jzfhl7TJV5Ixvojc
wPw838P9yBPcnxzhfcTOd2Ie3lfyxn9hvsX/kZzpdxP7P+5SNL6HlIzvyfnh
e5Hhe//d98P+X2vyuBU=
          "]]}, "Charting`Private`Tag#2"], 
       Annotation[{
         Hue[0.1421359549995791, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKAjEMhoODeuLBTe6ObqIObnkHH0FQ3HwVRxUHVx/BqYLTwSkHgiA4
KIooitwjyDX1hzRL+5H2S9LW++PeoEBEDSLKV4nMlGWzGdr4morjXZLHxwSO
2zbeyM9nebxMzbEsTxMp3wNsdcnd893A4ruaUPku6E/un8FTe/5kSqreEf21
rP+A87KkqCf3Y3DTnt96/jXyE8srz0dUdLyUPJcVr8Fd8Xv5mAPlS8Ed6Z//
841kPtxfyPzgVN6HdX8XsHtfDpX/Bv9e/ocrqt6Dq/p/OVK+F9eU743+xfdB
ffF9vXkz9PsDOpK36Q==
          "]]}, "Charting`Private`Tag#3"], 
       Annotation[{
         Hue[0.37820393249936934`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhcLTaJgCi9gaSdqYTd38AiCYudVLFUsbD1CqhWsBJWAIAgW
ESUYlJAjSHaWD2anmX3M7Jv9aY/no0lFKdVRSpWZo9AeL/ZTE7n2LZ9PZfxQ
75v46sDyelVGpluWOX10KHypblo2utPb8b0wj31P3RC+RNfE/gd4afrvYJ53
g69n/FfM4xSDef8R3DX9B6cegReGd45PqarlLdfJExyBh+ynmqgfyTkfeMDn
R/+M7wfe8P3RH/P7OL4E/fZ9qSH8L9Qv/D8UiHkp1eX/Uih8GbWE74v57PuB
2ZeTL3wF5v8BGoK30Q==
          "]]}, "Charting`Private`Tag#4"], 
       Annotation[{
         Hue[0.6142719099991583, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTsKwkAURQdB8mkMZAWWdqIWdrMHlyAodm7FUsXC1iWkGsEqECUgCIJF
JBIMCSFLkMwbL7y8ZuZwZ86bT3++ni06QoiBEKIZqWpl0+S81FUpx/A1aqpE
PtZVIN/vmsqVb5iGr/KYL1M9w1oXfVq+tOV7K5f5EmWx/S/wVq9/gqnfA76R
9t+R0xCjP+0PkQ/1+ksrD8AbzSfw/wW7ho+US5txAJ6SX1osDyX3xeAJnR/r
V3Q/8IHuD47pfSS/bwI27ytd5k+R3+h/pMP6ZWDzv9Jjvlz6zFfg/OQrweSr
Wr4a5/0BCTq3wg==
          "]]}, "Charting`Private`Tag#5"], 
       Annotation[{
         Hue[0.8503398874989481, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhoOg1S6F3sDRTdTB7d3BIwiKm1dxVHFw9QidIjgVqhQEQXCo
VIpSKT2CNC/+8PqW5ONPvuQl3elyMmsopXpKqWrkKnWbJ8e5qUJ3LJ+jqr7I
h6Zy5NtNVR/tW+bhrT3hy8BGF71qvhTMvqd2hS/Rjtj/AK/N+juYz7vBNzD+
K3Ie4tr+ENw360/Yz3mAfGX4gPz/gk3Le86pLTgAj9lPjshDkr4Y+YjvTy3L
C+4P+Y77Rx7z+5DsNwHb9yVX+FPkF/4f6ojzMrD9X/KE70O+8OXoh31fMPuK
mq/EfX/6o7e3
          "]]}, "Charting`Private`Tag#6"], 
       Annotation[{
         Hue[0.08640786499873876, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhoOg1Q4VegNHN1EHt9zBIwiKm1dxVHFw9QidIjgVqhQEQXCo
VIqlpXgEaV784eUt6cf/+iUv6c1W03lDCNEXQtQr1Ve16eO00FWBL1FdJXik
qwDvtnXlyjdMy0d5zJeprmGti97KYb7U8r2Uy3wJ+un/J3ij+x9g2u8O31D7
b8hpia3/Q/BA95+tPACvNR/h/99g0/CBcukwDsAT8ssWy0PJfTH6x3R+9C9p
PuR7mh95TPcj+bwJ2NyvdJk/RX6l95Edtl8GNu8rPebLpc98BeYhXwkmX2X5
vjjvD+w7t64=
          "]]}, "Charting`Private`Tag#7"], 
       Annotation[{
         Hue[0.3224758424985268, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRfBxBRpcgNLO1ELu72DRxAUO69iqWJh6xGsVrASogQEQbBQ
FIkYQo4g2b9+mEwzeczsm91JczgdjGpKqZZSqsyIwvj42I1t5Kbh+BiXkZG7
Nr7k5aKMj4kcI6UmFL432eriF+fB96z4HiYQvjv7cf5mPMdz238lY96Fvo71
n1lHSujD+QO5bfv3lfqWPLO8of+/wbrjNeraF7wl9+HXnqgftPQl7O/h/uyf
4H3kFd5PTrAfLd97p8/tVwfC/2T9hP/D+2Deu3K/VIfC99GR8H3ZD19GP3x5
xVew/gPYS7ee
          "]]}, "Charting`Private`Tag#8"], 
       Annotation[{
         Hue[0.5585438199983166, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRfBmBQ2uYGlnaiF3dzBIwiKnVexVLGw9QipVrASVAKCIFgo
iiQkhBxBsrP5MDvN5DE7b3Y2ncliPG0opbpKqSpzlLrFH4eZiQJ8OVeRa9/y
wEQG3qyrSHVomVOi28L3Axvd+Qs/+z6O760D4XtpT/Q/wStz/gHmeXf4+sZ/
Q51TjPncf0K9Z84fnXoEXhrew1+/YNPyjuvkCY6o7h+x36mfULf3Aw/5/lT7
57wf+re8Pzjm9yG57wts35cC4f9g3pX/D/li3o/kvgm1hS+lUPgyx5eD2Vc4
vhL7/wHOW7eW
          "]]}, "Charting`Private`Tag#9"], 
       Annotation[{
         Hue[0.7946117974981064, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoNgrUMHfQNHN1EHt7yDjyAobr6Ko4qDq4/QKYJToUpBEASH
SqVYWkofQZpLf7jccvm43JfkMlhs5suWEGIohKgzRaU6tLisdJTgW1hHAZ7o
yJVr+LCvI1N9w5R+ymO+FKx14dfyJZbvo7rMFyuH9b/BO73/BabznvCPtf+B
OqUIdeoPUB/p/VfL74O3ms/obybYNnyiunQY++AZ+a16ILkvAk/p/rLxr+l9
6D/S+8ERzUfy98ZgM1/ZZf4E593pf6TLzkvB5n+lx3yZ7DFfbvkKMPlKy1fh
vn/Ei7eO
          "]]}, "Charting`Private`Tag#10"], 
       Annotation[{
         Hue[0.030679774997896203`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhoNgbaGCHsHRTdTBLXfwCILi5lUcVRxcPUKnCE6FKgVBEByU
ilhaSo8gzUt/eHlL+vEn30tee7PVdN4QQvSFENVKVaoWfZwWugrwJaoqB490
ZeDdtqpUdQ3T8lM+831V27DWRR/LlyiX+d7KY76Xctj5p2oa3uj9DzD1u2P/
UPtvyGmJkdP5EPlA7z9beQBeaz7i/vUE6/MHyqXDOABPyG/loeS+GPmY7i9r
/5Leh3xP7wfHNB+wmR/YzFd6zJ+g/5X+D5j6faXLfD/pM18qO8yXWb7c8hWW
r8R9/7GDt4E=
          "]]}, "Charting`Private`Tag#11"], 
       Annotation[{
         Hue[0.266747752497686, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRfBJEUQr2BpJ2phN3fwCIJi51UsVSxsPYLVClaBKAFBECwU
JSQkhBxBspN8mJ1m8/g7b2c3vdlqOm8ppfpKqWrlKrXLH+eFqQJ8DavKwSNT
GXi3rSrV3Zp5SbQvfDHY6MKf5ftavo/2hO+tHdH/0u2aN2b/E8znPbB/aPx3
5LxEyLk/QD4w+y9WfgKvDR/BzQs2/QfOyRF8Ak/Yb+UBucIXIR/z/NT4l3w/
5Hu+Pzji9yE53xtcvy95wv9FfuP/g3n4vJjk/0jIF76UOsKXoZ99ueUrLF+J
ef+mC7d4
          "]]}, "Charting`Private`Tag#12"], 
       Annotation[{
         Hue[0.5028157299974758, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoOo7SB9B0c3UQe3ewcfQVDcfBVHFQdXH6FTBCdBpSAIgkOl
IpaW0keQ5tIfLrckH3f35ZJ0p8vJrKGU6imlqpWj1G3eHOcmCu1Zvl6qyMFD
Exl4u6ki1YFlXn66I3xfsNFdPjiPfYnje2tf+GLUc/9LtyyvTf0TzOc9UD8w
/jvyvETIc/8Z+b6pPzn5ELwyfADXL1j37zlPbcEheMx+kvVn8oQvQv2I56em
5QXfD/07vj844vchOV8Mtu9LvvAnyN/4fzAPn/cl+R8/6ghfSoHwZY4vd3yF
4ysx7x+ZA7dv
          "]]}, "Charting`Private`Tag#13"], 
       Annotation[{
         Hue[0.7388837074972656, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhfRKERyB0s7UQu7uYNHEBQ7r2KpYmHrEVKtYBWIEhAEwSIS
CZGIeATJzvrB7DS7j2/27V9nshhPa0qprlKqGrm+2uPJYWbqo5uWT3FVb/DA
VAnerKt66cAyD4X2hS/XbctGFz+xH/syx/fQLeFL0c/r77pheWX6b2De74r+
vvFfkPOQOOsjcM/0H7Ge8xD50vAe+f8F//mOc/IEh+AR+0n2R9QUvgT5kM9P
dctzvh/yLd8fnPD7kDxfCrbvSy3hz5Cf+X/AvF9O8j8K8oXvRYHwlY7v7fg+
ju+L8/4Akdu3aA==
          "]]}, "Charting`Private`Tag#14"], 
       Annotation[{
         Hue[0.9749516849970554, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KAkEMhQfxD0TvYGknamGXO3gEQbHzKpYqFrYeYasRrIRVFgRBsFAU
cdlFPILsvPVBJk3m4yVvJpnmcDoYFYwxLWNMlhFfW8ZhO3bxIR/CLFJy10Vi
KzkvF1nEtpEz0tvWlN+L7OzCp+f3IMPvTn+kmy2p/it57uovZNx3pl/H+Z+o
I0Ve/57cdvU79kMPqM8cb6j/N/jX19ClrDgg9+Evun4vet6Ieg/vl2LOE8xH
fYX5yRH2I/p9N+r5fnkf/B+sP+J/yLjvJVX9v1JTfrHUlV/i+aWe38eb98v3
/gCDS7de
          "]]}, "Charting`Private`Tag#15"], 
       Annotation[{
         Hue[0.21101966249684523`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhcxSSE5hKWdqIXd3MEjCIqdV7FUsbD1CKlWsApECQiCYBGJ
hAQl5AiSneSD2Wl2H9/um/3pz9ezRUcpNVBK1SNXpV2enJemSvA1qusHHpv6
aq/h/a6uQvsN85DrnvBlYKOLPpYvBbPvDT8PiXbE/hd4a9Y/wdzvAd/I+O+6
K3yxtT8ED836i5UH4I3hE/ztC7b+I+fkCg7AU/aTI/KQpC9GPuHzU+tf8f2Q
H/j+4Jjfx/IlyJv3JU/4U+Q3/h8w98tI/kdOPeEryBe+L/qz7wdmX2n5Kpz3
D3ort1Y=
          "]]}, "Charting`Private`Tag#16"], 
       Annotation[{
         Hue[0.44708763999663503`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhfRBCI5hKWdqIXd3sEjCIqdV7FUsbD1CFYrWAWiBARBsIhE
QkJCyBEkO9kPZqfZfczMm/0ZLDbzZUcIMRRCNCtFrRzaXFc6KvA9bKIET3QU
ym35sG8iV37LtGTKY75U9VvWuvBn+RIw+b7w0xKrHuv/gHe6/g2meS/4xtr/
VF3mi6z+ADzS9TcrfwFvNZ/hNy9o/CfKS4fxRZr+GfnBlA8k90XIT+n80vjX
dD/wke6P+ojex/LFyLfvK13mT5B/0P+AaV4q+X9k0mO+XPrMV2A++UrLV1nn
q8F/dVu3UA==
          "]]}, "Charting`Private`Tag#17"], 
       Annotation[{
         Hue[0.6831556174964248, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb8KwjAQh4NoC/55CEc3UQe3ewcfQVDcfBVHFQdXH6FTBKdClYIgCA6V
SmlpKX0EaS79QXJL8nF3Xy7JcLldrFpCiJEQol45KtnhzXWtopSO5ntQRwGe
qsjBx0MdmRxo5iWVXcOXyJ5mpQt+li+2fF/pGr4I83H/R7Y171X925r/BZ4o
/xP1vIRWvw8eq/ob+jnvIb9TfMG8zQs2+TPnyTHYo8Y3Zz+Y8z6ZvpAa34zn
B2/4fuAT3x8c8vtYvgjn6fcl1/DHyD/4f8B8XkLmf6TUNXwZ9Q1fjvPZV1i+
0pqvAv8BZlu3Rg==
          "]]}, "Charting`Private`Tag#18"], 
       Annotation[{
         Hue[0.9192235949962146, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoNYi6Uv4egm6uCWd/ARBMXNV3FUcXD1ETpFcCpUKQiC4KBU
SktL6SNIc+kPl1uSj0u+3F0Gi8182RFCDIUQzUpRK4c2l5WOSvUM36ImSvBE
RwE+7JvIlW+Ylkx5zJeqvmGti36WL8H75Psql/k+yNP9t+oa3unzL6v+J3is
/Q+cpyW27ofgkT5/xX3KB8hvNZ9RfzvBNn+ivHQYB+AZ+a18KLkvlq1vSvWD
19Qf+Ej9g2OaD/xmftKar3SZP0H+Tv8DpvdSyf8jkx7z5dJnvgL9kK+0fJXV
b416/1vDtz8=
          "]]}, "Charting`Private`Tag#19"], 
       Annotation[{
         Hue[0.15529157249600445`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoNYi6Uv4egm6uCWd/ARBMXNV3FUcXD1ETpFcCpUKQiC4KBU
SktL6SNIc+kPl1suH5d8yV0Gi8182RFCDIUQTaaolUOLy0pHpXqGb1ETJXii
owAf9k3kyjdMKVMe86Wqb1jroh/uI18CJt9Xucz3QZ3Ov1XX8E7vf1nvf4LH
2v/AfkqxdT4Ej/T+q1UPwFvNZ/TfTrCtn6guHcYBeEZ+qx5K7otl65vS+8Fr
6g98pP7BMc0HfjM/ac1XusyfoH6n/7HuSyX/j0x6zJdLn/kK9EO+En7yVVa/
Nd77B1e7tzw=
          "]]}, "Charting`Private`Tag#20"], 
       Annotation[{
         Hue[0.39135954999579425`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhoNaxeIlHN1EHdzeHTyCoLh5FUcVB1eP0CmCU6GKIAiCg1IR
xVI8gjR//CF5S/rxv355SZrD6WBUUkq1lFLFivrqAB/bsalcVy3vk6IyctfU
h7xcFPXWDctYXjp0fE9dt2x0yYP7wZeS4bvTj+XGHP9fdcXy3PRfvPnP5I7x
n9iP5ej9H5Pbpn/n5RF5ZnjjzafUP18jl8DhiNyHX9z+mLmdj3kP80vZ8gTn
Y77C+clH3I/nu4l3v1J1/CnzA96HPuz3lJr7vhI6vrc0HN+Hfvgy+uHLxb2/
L+f9AVIjtzc=
          "]]}, "Charting`Private`Tag#21"], 
       Annotation[{
         Hue[0.6274275274955841, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKAjEQRYO6C65ewtJO1MJu7uARBMXOq1iqWNh6hK0iWC2oLAiCYLGi
iKLIHkE2P35Ippk8ZvIySRqDSX9YUko1lVJFRuS6gsVmZOKrA8v7XREfHVru
mHiTF/MiXrpuGempI8f30FXLRre70w/fjQzflX6kjHXsv3Demek/e/Of2N82
/iPrSKm3PyG3TP/Wq8fkqeE1/f8X/NdXqEvgcEzuwS9ufyKuL2W9i/mlbHmM
+7G+xP3JKd7H82Xiva+Ejv/G/Qf8DxnnPcT9j6dEju8lNcf35nnwfcjwfT1f
znl/SJO3Lw==
          "]]}, "Charting`Private`Tag#22"], 
       Annotation[{
         Hue[0.8634955049953739, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhoPagu0pHN1EHdxyB48gKG5exVHFwdUjOEVwKlQpCILgUKmU
lpbSI0jz0h9e3pJ8/MmXl2Sw2MyXHSHEUAjRjFS16tHkutJVKcfwPWyqVK7h
ia4CfNg3lSvfMA2Z8pgvVX3DWhf+4CdfAibfF34aYvRH+z/gnV7/tvp/wTfW
/qfqMl9k7Q/AI73+ZuUX8FbzGf72Bdv8RLl0GF/AM/JLvj6Q3Bchn1L/su1/
TfdDfqT7gyN6H8sXIzfvK13mT5A/6H/AdF4q+X9k0mO+XPrMV+B88pWWr7J8
Nfr9A0Hrtyo=
          "]]}, "Charting`Private`Tag#23"], 
       Annotation[{
         Hue[0.09956348249516367, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhoPagvQUjm6iDm7vDh5BUNy8iqOKg6tHcIrgVKhSEATBoVIp
LRXpEaR5zQ8vb0k+/uTLS9KbrabzllKqr5SqR65Kd3hyXpj6aa/ha1TXV/sN
j0yV4N22rkIHDfOQ667wZWCjiz7wsy8Fs+8NPw8J+uP9L/DGrH86/T/gGxr/
XbeFL3b2h+CBWX9x8hN4bfgIv31Bmx84J0/wiWw+YT/J9SFJX4x8zP2T7X/J
90O+5/uDY34fx5cgb96XfOFPkd/4f8B8XkbyP3LqCl9BgfCVOJ99X8f3c3wV
+v0DPjO3Jw==
          "]]}, "Charting`Private`Tag#24"], 
       Annotation[{
         Hue[0.3356314599949535, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT8KwjAUh4N/itBTOLqJOrjlDh5BUNy8iqOKg6tH6BTBqVClIAiCQ6VS
WpTSI0jzS3+QvOXl4+V9eUn68/Vs0RJCDIQQdUZUqoPFeamjVF3D16iOn/IM
j3V8yftdHYXyDSPlqmf5MrLWRR/64UvJ8L3pR0o4H/pfqm14q/c/nfkf9I20
/879SLHTH7J/qPdfyKgH5I3mE/3NCzb1I+rS5oA8hd+ph9L2xbKZb4L5ySvc
j/0H3J8c430cX8K6eV/pWf6U9Rv+h4zzMmn/Ry57lq+QvuX78nz4fo6vdHwV
638z07cf
          "]]}, "Charting`Private`Tag#25"], 
       Annotation[{
         Hue[0.5716994374947433, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoPWUuhTOLqJOrjlHXwEQXHzVRxVHFx9hE4RnApVCoIgOFQq
paWl9BGkufSHyy2Xj7t8uSTD5Xax6gkhRkKINlM0yqHFda2jVgPD96iNCjzV
UYKPhzYK5RumlCuP+TKw1kU/y5davq9ymS/BfLT/o/qG97r/bc3/gm+i/U/0
U4qt/SH2j3X/DUz1ALzTfIG/e8HOd6a6dBgH4Dn5rXoINvPJzjej+cEbuh/6
T3R/cEzvI/l8CermfaXL/CnqD/ofMJ2XSf4fufSYr5A+85U4n3yV5astX4P7
/wEsw7cb
          "]]}, "Charting`Private`Tag#26"], 
       Annotation[{
         Hue[0.8077674149945295, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoPWUvoWjm6iDm55Bx9BUNx8FUcVB1cfoVMEp0KVgiAIDpVK
aWkpfQRpLv3hckvycZfvLslwuV2sekKIkRCiXSka5dDmutZRq4Hhe9RGBZ7q
KMHHQxuF8g3TkiuP+TKw1kU/9CNfavm+ymW+BPV0/qP6hve6/m3N/4Jvov1P
1NMSW+dDnB/r+huY8gF4p/kCf/eCne9MeekwDsBz8lv5EGzmk51vRvODN3Q/
1J/o/uCY3kfy+RLkzftKl/lT5B/0P2Dql0n+H7n0mK+QPvOV6E++yvLVlq/B
/f8oG7cY
          "]]}, "Charting`Private`Tag#27"], 
       Annotation[{
         Hue[0.04383539249432289, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhd/QsgtLO1ELez2Dh5BUOy8iqWKha1HSLWClaASEATBQlEk
Ygg5gmS/zQez00weM/sys9sazYbjmlKqrZQqM6IwDXzsJjZy8ulYRmaajns2
fuTVsoyviRwjpSYUvg/Z6o5v+uF7keF7mkD4Hqzj/N3UHS9s/82b/0ruWv+F
/UiJd/7A/o7t35NRj9k/t7zl/tUNVvUN6rohOCYP4PfqB7KbT1e+PuYnT7Ef
eY39yQnux/M9tHe/OhD+F8+f8T7sx/8+Wu6b6lD4vjoSvh/74cs8X67l+xac
9w8dM7cP
          "]]}, "Charting`Private`Tag#28"], 
       Annotation[{
         Hue[0.27990336999410914`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhoPWIt7C0U3UwS138AiC4uZVHFUcXD1CpxScCioFQRAcKpXS
opQeQZo//SF5S/rx/nx9Sfrz9WzREkIMhBD1iqqUh49wqaskXy91/VTH8FjX
l7zf1VWonmEsuepavoysdZcP/fClZPjeyrd8CfvY/1Jtw1udfzrzP8gj7b8z
jyV29kfMD3X+TEY/YH6j+cTzNzfY9I/oS8/igDyF3+lHZDOfbHwTzC/NW4Ur
nI98wPmZj3E/ji+Rzv1K3/Kn3H/D+zCP/2XSPm8uu5avkD3L92Uevp/jKx1f
xXn/G1u3DA==
          "]]}, "Charting`Private`Tag#29"], 
       Annotation[{
         Hue[0.5159713474939025, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRReNQXILSztRC7u9g0cQFDuvYqliYesRUm3AKhAlIAiCRSQS
EhJCjiDZ2XyYnWbzmJmXmd3Rardc94QQYyFEe1I0yqGPYKOjBt+jNio1MDzT
UYJPxzYK5RmmI1dD5svAWhf94CdfCibfV7nMl6g+6/+AD7r+bc3/Ak+1/4l6
OmKrP0T9RNffwJT3Ub/XfMX+3Q12+QvlpcPYBy/Ib+VDsJlPdr45zS/NWwVb
2g98pv1RH9P9WL4EeXO/0mX+FPkHvQ/66X+Z5Pvmcsh8hfSYr0Q/+SrLV1u+
BvP+ARiTtwk=
          "]]}, "Charting`Private`Tag#30"], 
       Annotation[{
         Hue[0.7520393249936888, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhoPWCt7C0U3UwS138AiC4uZVHFUcXD1CpxScCioFQRAcKpXS
opQeQZo//SF5S/LxXr68l/Tn69miJYQYCCHqFVEpD5twqaMkXy91/FTH8FjH
l7zf1VGonmEsuepavoysdZcP/fClZPjeyrd8iWpb51/kra5/Ov0/yCPtv7Me
S+ycj1g/1PVnMvIB6zeaT5y/ecEmf0ReehYH5Cn8Tj4im/5k45ugf2n+Klxh
PvIB87M+xvs4voR5877St/wp8zf8Dxn3ZdKeN5ddy1fInuX78n74fmT4SsdX
sd8/E2O3BQ==
          "]]}, "Charting`Private`Tag#31"], 
       Annotation[{
         Hue[0.9881073024934821, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhd/IuQWlnaiFnZ7B48gKHZexVLFwtYjpNqAVSBKQBAEi4gi
ESXkCJL9kg9mp9l9zMzb3dnudDmZNZRSPaVUuSIK08ImnNvIyae4jJ9pVzy0
8SVvN2V8jF8xlsx0hO9Ntrr4RT98TzJ8D+MJX2qaov9OXtv6m3P/K3lg/RfW
Y0mc/ojct/VHJx+QV5YP9NcTrPN75LXkQNf1Y/jJyEda+hL2j3B/Xf1VuMD7
yDu8n/UJ5uP4Uuar+WpP+J/Mn/E/ZJz31m3hy3RH+D7aF74vz4fvR4Yvd3wF
7/sHDdO3AQ==
          "]]}, "Charting`Private`Tag#32"], 
       Annotation[{
         Hue[0.22417527999326836`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRc1EXILSztRC7u5g0cQFDuvYqliYesRUm3AKhAlIAiCRSQS
EpSQI0h2kg+z02wef/bt7Gaw2MyXHaXUUClVr1yV7vFHsDJVgq9RXT/tNDwx
9UV+2NdVaK9hXnLdF74MbHTRB/vZl1q+t3aFL9Fdsf8F3pn+pzX/Azw2/jv6
eYmt/SF4ZPovVu6Dt4bP8Lcv2OYnzkmyT23/jP1gzkOy5gNPeX5q/lWw5vuB
j3x/9Mf8PiTnS5A370uu8KfIb/x/wHxeRo7w5dQXvoI84fvifPb9wOwrLV+F
ef8Kc7b/
          "]]}, "Charting`Private`Tag#33"], 
       Annotation[{
         Hue[0.4602432574930617, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRZeYEHIMSztRC7u9g0cQFDuvYqliYesRUq1gFYgSEATBIhIJ
CQkhR5DsbD7MTjP7+TNvZ2eHy+1i5QghRkKILlO0akCH61pHo1yj73EXtfKM
nuqo4B8PXZQqMJpSoXzGy6E1Lv7hPuJlFu+L+yilqKf+D/Re17+t+V/gTTT/
qRzGS6CpP0L/WNffLH4IvdP6An6/wd4/ky+5DqHnxJcu8yP4Zj7Zzzej+aE3
9D7oE70f/QntR/L5Uvhmv9Jj/Az+g/4Hmu7LLV4hfcYrZcB4FeqJV1u8RvL/
bfH+P/jktvE=
          "]]}, "Charting`Private`Tag#34"], 
       Annotation[{
         Hue[0.696311234992848, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhkO1lT6Go5uog1vewUcQFDdfxVHFwdVH6BTBqVClIAiCQ6VS
WlpKH0GaS3+43JJ83N2XSzJcbhcrRwgxEkK0K0WjerS5rnXUqm/4HrVRgac6
SvDx0EahfMO05MpjvkwNDGtd9MN55Est31e5zJegnvo/4L2uf1vzv+CbaP9T
OcwXg6k/RP9Y198sfwDeab7A371glz9TXnIOwHPyW/kQbOaT3Xwzmh+8ofuB
T3R/9Mf0PpLPlyBv3le6zJ8i/6D/AdN5meXLpcd8hfSZr0Q9+SrLV0v+vw3u
/wfy1Lbt
          "]]}, "Charting`Private`Tag#35"], 
       Annotation[{
         Hue[0.9323792124926413, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoPaSh/D0U3UwS3v4CMIipuv4qji4OojdErBqVClIAiCQ6VS
WlpKH0GaS3+43HL5uMuXSzJa7ZbrnhBiLIRoM0Wj+rQINjpqNTB8j9qowDMd
Jfh0bKNQnmFKuXKZL1NDw1oX/XAe+VLL91UO8yXop/0fZWYPDrr/bc3/Ak+1
/4l+SrG1P0T/RPffwFT3wXvNV8zbvWDnu1Bd9hn74AX5rXoINvPJzjen+cFb
uh/4TPfH/pjeR/L5EtTN+0qH+VPUH/Q/YDovs3y5dJmvkB7zlegnX2X5asn/
t8H9/+38tuo=
          "]]}, "Charting`Private`Tag#36"], 
       Annotation[{
         Hue[0.16844718999242758`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhd/cw1LO1ELu72DRxAUO69iqWJh6xGsNmAViBIQBMEiooSE
hJAjSPbbfLA7zeYxM29nJ4PFZr5sCSGGQoj6RFSqjQ9/paMk38I6CtUxPNGR
kw/7OjLlGcaRqp7lS1TfsNaFP/rh+zq+j+pavpj16H8rM7u/0/UvZ/4neaz9
D9bjiJz+gPUjXX8lI38hbzWfOW+zwcZ3Ql62Lb6QZ/A7+YBs5pONb4r5yWu8
j3zE+9kfYT/Sni9m3uxXdi3/l/k7/g8Z9yWOL5U9y5dJz/LlrIevcHyl46v4
/j/o3Lbm
          "]]}, "Charting`Private`Tag#37"], 
       Annotation[{
         Hue[0.40451516749222094`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb0KwjAUhYO/fQ1HN1EHt7yDjyAobr6Ko4qDq4/glIJToUpBEASHilJa
WkofQZqTHkjukn7cky836WCxmS9bQoihEKJeUZVq48Nf6SrJt7CuQnUMT3Tl
5MO+rkx5hrGkqmf5EtU3rHXhj374vo7vo7qWL2Ye+9/KzO7vdP7lzP8kj7X/
wTyWyNkfMD/S+SsZ/Qt5q/nMeZsXbHwn9GXb4gt5Br/TD8hmPtn4ppifvMb9
yEfcn/sjvI+054vZN+8ru5b/S98d/4d5nJc4vlT2LF8mPcuXMw9f4fhKx1fx
/n/oVLbl
          "]]}, "Charting`Private`Tag#38"], 
       Annotation[{
         Hue[0.6405831449920072, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRZfEYK5haSdqYbd38AiCYudVLFUsbD1CqhWsAlECgiBYRCIh
EpEcQbJ/82F3mtnHzP87s9ubraZzTwjRF0I0GVErH4fTQsePfEma+KqO4ZGO
irzbNvFRoWGkUgWWX6G6hrVd8lae5Zc7fi/qkTLOA/2T+o3uf5Bx3539Q+1/
Yx0pdfQxeaD7z9SjHpHXmo+ct33BVn9AXfoWR+QJ/KXdH7Nu5mN9jPnJS+xH
3mN/cor3kfZ8Gf3N+8rA8s+pv+J/2I/7CsevpN78vwwtv4r98Ps6fj/Hr+b+
f958tt4=
          "]]}, "Charting`Private`Tag#39"], 
       Annotation[{
         Hue[0.8766511224918005, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRZfESK5haSdqYbd38AiCYudVLFUsbD1CqhWsAlECgiBYRCIh
EpEcQbJ/82F3mtnHzP87s9ubraZzTwjRF0I0GVErH4fTQsePfEma+KqO4ZGO
irzbNvFRoWGkUgWWX6G6hrVd8lae5Zc7fi/qkTLOA/2T+o3uf5Bx3539Q+1/
Yx0pdfQxeaD7z9SjHpHXmo+ct33BVn9AXfoWR+QJ/KXdH7Nu5mN9jPnJS+xH
3mN/cor3cfwysnlfGVj+OfVX/A/7cV8h7X1L6s3/y9Dyq9gPv6/j93P8as77
B9ucttw=
          "]]}, "Charting`Private`Tag#40"], 
       Annotation[{
         Hue[0.1127190999915868, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRReTiNewtBO1sNs7eARBsfMqlioWth7BagWrQJSAIAgWkUiI
JIQcQbJ/82F3msljZt7Obvrz9WzREUIMhBBNRtTKfF+WOirlGb5FTZTksY5C
+Yb3uyZ+qmcYKVeB5ctU17DWRV+eB1/q+D6cR0rYj/k3eav7X87+T+470v4H
60ixMx+Sh7r/ynnUz+SN5hO5fcF2/oi69Cw+k6fwS7s/lLYvZn2C/ckr3I98
wP3JMd7H8SWsm/eVgeVPWb/j/3Ae52XSt3w5583/lz3LV7AfvtLxVY6v5r5/
0sS21w==
          "]]}, "Charting`Private`Tag#41"], 
       Annotation[{
         Hue[0.34878707749138016`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTsKwkAURQeT6Dos7UQt7GYPLkFQ7NyKpYqFrUuwGsEqECUgCIJFJBIi
CSFLkMydXJh5zcvhzjvzSX++ni06QoiBEKLpqFqZ78tSV6U8w7eoqZI81lUo
3/B+19RP9Qyj5SqwfJnqGta66Mv94Evph+/DebSE6zH/Jm/1+pdz/id9I+1/
MEeLnfmQPNTrr05+Jm80n+hvX7DNj8ilZ/GZPIVf2utDafti5hOcn7zC/cgH
3J8c430cX8LcvK8MLH/K/I7/w3nslzm+nPPm/8ue5Sukb/lKx1cxR6vp/wPK
5LbR
          "]]}, "Charting`Private`Tag#42"], 
       Annotation[{
         Hue[0.5848550549911664, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRdDzDks7UQt7PYOHkFQ7LyKpYqFrUdItYJVIEpAEASLSCRE
EkKOIJnZfNiZZvbzZ97szg4Wm/myp5QaKqXazNEYe76sKGrjWX2L26igJxQl
9GHfxs8EVnMqjO/wctO3mnDxF/OYlwneB/2cUtRz/xt6R/Uvcf8neGPiP+Bz
SkR/BD2i+qvwQ+gt6TP43QY7/8S+9hwd6s6fMV+79ZF2eQn8Kd8fes3vgz7y
+6ET3o/gpfDtfrXv8DP4d/4f9PO8XPAK9Nv/14HDK1HPvErwasFrMP8Pxwy2
zA==
          "]]}, "Charting`Private`Tag#43"], 
       Annotation[{
         Hue[0.8209230324909598, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhcluYelnaiF3d7BIwiKnVexVLGw9QipVrAKRAkIgmARiYRI
QsgRZGc2H+xMM3l8s29/Mlhs5sueUmqolLKdqzXu+7Kiakzf8S2xVYMnVBX4
sLf1M6FjbqUJPF+BnHTJF/uxLxe+D9ZzyzDP69/gHc2/xPmf8I3J/0DOLRXr
Y/CI5q8ij8Bb4jP83Qt2+Ylz7XMEnrFf5LH2fSnyKZ8fvOb7gY98f3DK7yN8
GXL3vjrw/DnyO/8fsV8hfCXWu/+vQ89XYZ59tfA1wtci/wPCpLbH
          "]]}, "Charting`Private`Tag#44"], 
       Annotation[{
         Hue[0.05699100999074602, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRldNcg9LO1ELu72DRxAUO69iqWJh6xFSrWAViLIgCIJFJBIS
EkKOINnZfLAzzeTxzb79yXC5Xaz6QoiREKLtVI2y39e1qRp8j9uq1MDy1FQJ
Ph7aKlRgmVqufMeXITe6+Ac/+VLm+yrP8SWYp/Uf8N7Mv9n5X/BNjP+JnJpm
6yPw2MzfWB6Cd4Yv8Hcv2OVnyqXLIXhOfpZH0vVp5DM6v+xZ3tD9kJ/o/mBN
78N8CXL7vtJz/CnyB/0fMO2XMV8ufcdXyMDxlZgnX8V8NfM1yP+8tLbD
          "]]}, "Charting`Private`Tag#45"], 
       Annotation[{
         Hue[0.2930589874905394, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRVcN3sPSTtTCbu/gEQTFzqtYqljYegSrFawCUQKCIFhEIiGS
EDyCZP/mw840s58/83ZntjdbTedtpVRfKVVnxM+483lho6K+RnWUpuP0yEZB
vdvW8TVdp5FyE3i8jL7FRR/ywUsF781+pIT16H9Rb2z907S8+x7kDS3/znqk
WPSH1ANbfxH+iXpt9ZH8ZoONf4CvfX2inoAv/FD7vJj+GO/XzXxLzEd/j/mp
Y+xH8BL6br868Pgp/Rv+hxr3ZYKXs9/9v+56vIL14JWCVwnej/4fuFy2wA==

          "]]}, "Charting`Private`Tag#46"], 
       Annotation[{
         Hue[0.5291269649903256, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRVcNuYelnaiF3d7BIwQUO69iqWJh6xFSrWAViBIQBMEiEgmR
hJAjSPZvPuxOM/v4M39ndofBZrHsCyFGQog2IxplzpeVjpp8i9uo1MDwVEdJ
Puzb+CnfMFKhPMsvp67t4i/94Zc5fh/2I6WsR/+bvNP1L9Wz7ntSn2j/Bxkp
cfoj8ljXXx09JG81nzlv94KdfoIubQ7Jc/g7eiRtv4T6DPPLbr819qN+xP7k
BO8j7X1Tsnlf6Vn+GfU7/oeM+3JnvoL95v+lb/mVrIdf5fjVjl/Def+17La+

          "]]}, "Charting`Private`Tag#47"], 
       Annotation[{
         Hue[0.765194942490119, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSrWAViBIQBMEiooRI
QsgRJDubDzPTzD7+zN+Z3f58PVt0lFIDpVSTKWrjzueljQp8jZsoTdfx2EYB
3u+a+JnAMaXc+MwvMz3H1i7+wp/8PsLvjX5KKeqp/wXe2vqn8dh9D+gj638H
U0pEfwQe2vqL0EPwxvIJ87Yv2OpH0jXnEDwlf+0xPdLcL0H9hOZH/Yr2g36g
/cEJvY/m+6Zg977aZ/4f6Df6HzDdl4n5cvS7/9cB8yuEXyn8KuFXY94/snS2
uw==
          "]]}, "Charting`Private`Tag#48"], 
       Annotation[{
         Hue[0.0012629199899052423`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSrWAViBIQBMEiooRI
QsgRJPs3H3anmX38mb8zu/35erboCCEGQogmI2plzueljop8jZsoVdfwWEdB
3u+a+KnAMFKufMsvUz3D2i7+0h9+H8fvzX6klPXofynP8FbXP8m478H6kfa/
U0dKnP6I9UNdfyFDD8kbzSfO275gqx+hS5tD8hT+0rP0iLqZj/oE85NX2I/1
B+xPPcH7OH4p2byv9C3/D/Ub/oeM+zJp75uz3/y/DCy/wvErHb/K8as57x+q
lLa1
          "]]}, "Charting`Private`Tag#49"], 
       Annotation[{
         Hue[0.2373308974896915, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSrWAViBIQBMEiooRI
QsgRJDObD7PTzD7+zN+Z3f58PVt0lFIDpVSTOWpjz+clRQW+xk2U4DFFAd7v
mviZwDKn3PjCLzM9y2QXf40n/D6mK/ze6OeUop77X+At1T/BfN8D843I/w6d
U+L0R6gfUv0FzHoI3hCfMG/7gq1+ZF1LDsFT9tee0CPodj7oE54fvOL9wAfe
H5zw+zh+KXT7vtoX/h/U3/h/wHxfpuW+Ofrt/+tA+BWOX+n4VY5fjXn/oFS2
rw==
          "]]}, "Charting`Private`Tag#50"], 
       Annotation[{
         Hue[0.47339887498948485`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRTcacw9LO1ELu72DRxAUO69iqWJh6xFSbcAqECUgCIJFJBIi
EckRJPs3H3anmX38mb+zs/35erboCCEGQogmI2rl4RAtdfyU0aJL0sSXPNZR
kfe7Jj4qMIxUKt/yK1TPsLZL3rwPfrnqWn4v9iNlrEf/k7zV9Q9n/jvnG2n/
G3Wk1OmPyUNdf2Y/9JC80XzivO0GW/0IXdockqfwl56lx9TNfNQnmJ+8wvvI
B7yfnGI/jl9G3exX+pZ/zvor/oeM+wrHr2S/+X8ZWH6V4/d1/H7S3l9N/z+b
3Las
          "]]}, "Charting`Private`Tag#51"], 
       Annotation[{
         Hue[0.7094668524892711, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRdeYHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYSE
hJAjSPYnH3anmX38mb+zs6PVbrl2hBBjIUSbEY0a4BBsdNSq04J71EZFnuko
yadjG4XyOkbK1dDwy6hru+jH++CXsh5+X+Uafgnr0f8hH3T925r/xfmm2v9J
HSm2+kPyRNff2A/dJ+81Xzlvv8G+/wJdOgb75AX8pVkfUu/moz7H/OQt3kc+
4/3kGPux/BLq3X6la/inrH/gf8i4L7P8cmn+VyE9w6+0/Cpr/trya8h/lTS2
pQ==
          "]]}, "Charting`Private`Tag#52"], 
       Annotation[{
         Hue[0.9455348299890574, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRdeYHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYSE
hJAjSPYnH3anmf38mbezs6PVbrl2hBBjIUSbEY0a4BBsdNSq84J71EZFPdNR
Up+ObRTK6zRSroYGL6OvcdGP94GXsh68r3INXsJ69H+oD7r+bc3/4nxTzX/S
R4qt/pB6outv7IfvU++1vnLefoN9/wW+dAztUy/Al2Z9SL+bj/4c81Nv8T7q
M95PHWM/Fi+h3+1XugY/pf/A/1j3ZRYvl+Z/FdIzeCXrwassXm3xGuo/lDS2
ow==
          "]]}, "Charting`Private`Tag#53"], 
       Annotation[{
         Hue[0.18160280748885782`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAURNeEHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYSE
hJAjSHbWgd3f/Dxm/uzfzXC5Xaw8IcRICNF3VKcG+IjWulpltOiW9NWQp7pq
8vHQV6UCw2il8q28grqOS748D3k5/cj7kNEy+jH/Ju+1/+Xs/+R+E53/oI6W
OvMxeaz9V85DD8k7zRdnPyH+82fo0rM4JM+RL21/TN3sR32G/ckb3I98wv3J
Kd7Hycuom/eVvpWfU7/j/zjnFU5eKe3/VcnAyqvpR17j5LVOXkf+AZGktqE=

          "]]}, "Charting`Private`Tag#54"], 
       Annotation[{
         Hue[0.4176707849886441, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRdeEHMTSTtTCbu/gEQTFzqtYqljYeoRUCVgJUQKCIFhEIiGS
EHIEyf71w840s58/82Z2tz9fzxaeUmqglOoyoo16OMRLE01kvfiadFFTj01U
1PtdF98osBqpjHyHV9A3uOTDeeDlgvdmP1LGevS/qLem/in2f1CPDP9OjZSK
/gv10NSfuQ/8kP7G6JPYT6m/f4SvPUeH1FPwtVt/oW/3oz/B/tQr3I/6gPtT
p3gfwcvo2/fVvsPP6d/wP2JeIXgl++3/68DhVawHrxa8RvBa+j+MdLad
          "]]}, "Charting`Private`Tag#55"], 
       Annotation[{
         Hue[0.6537387624884303, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRdeEHMTSTtTCbu/gEQTFzqtYqljYeoRUG7AKRAkIgmARiYRI
QsgRJPs3H3anmf38mbezs8PldrHyhBAjIUSXEa0a4BCtdTTKeNEt6aKmnuqo
qI+HLn4qMBqpVL7FK+hrXPLlfeDlDu/DfqSM9eh/U+91/cuZ/0k90fwHNVLq
9MfUY11/5TzwQ/o7rS/0+w32/hm+9CwdUs/Bl3Z9LG1eSn+G+ak3eB/1Ce+n
TrEfh5fRN/uVvsXP6d/xP859hcMr2W/+XwYWr2I9eLXDaxxeS/8Pixy2nA==

          "]]}, "Charting`Private`Tag#56"], 
       Annotation[{
         Hue[0.8898067399882166, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRdckF7G0E7Ww2zt4BEGx8yqWKha2HiHVBqwCUQKCIFhEIiGS
EHIEyf7Nh91pZj9/5s3s7nC5Xaw8IcRICNFlRKsGOERrHY0yXnRLuqippzoq
6uOhi58KjEYqlW/xCvoal3w5D7zc4X3Yj5SxHv1v6r2ufzn7P6knmv+gRkqd
/ph6rOuv3Ad+SH+n9YV+/4K9f4YvPUuHsvfn4Eu7PpY2L6U/w/7SjIk2uB/9
E+5PneJ9HF5G37yv9C1+Tv+O/6HGvMLhlew3/y8Di1c5vNrhNQ6vpf8HhBy2
lg==
          "]]}, "Charting`Private`Tag#57"], 
       Annotation[{
         Hue[0.12587471748801704`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhVeTi1jaiVrY7R08gqDYeRVLFQtbj5BqA1ZClIAgCBaRSIgk
hBxBsi95sDPN5PHtfNmfwWIzX/aVUkOlVNNRtenhI1zZqkzLwlvUVEk+sVWQ
H/ZN/YzfZrTceI4vI7e66Ct8qfB9OI+WcD3m38w7u/4l9v9kHlv/gxktNsqZ
v5KP7PoL9wMekG9tPpN3N9jxE7h2c8A8g1/wq3Z9se72N8X+mdc4H+ePOD9z
jPsRvoS8vV/tOf6U/I73Ycb/MuHLOd++v/YdXyF8pfBVwleT/wF97LaS
          "]]}, "Charting`Private`Tag#58"], 
       Annotation[{
         Hue[0.3619426949878033, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhqP1Io5uog5uuYNHEBQ3r+Ko4uDqETql4FSoUhAEwaFSKZWW
0iNI86c/9L3l9edLvr4kw+V2seorpUZKqaajatPDR7C2VRnHglvUVEk+tVWQ
Hw9N/YznMlpODl9mBi5bXfQVvlT4PsKXcD32v5n3dv1LzP9knlj/gxktNqqz
PyQf2/VXzgPuk+9svpC3N9jyM7juZp95Dr/goe76Yt3ON8P8zBucj/tPOD9z
jPsRvoTc3a/2Ov6U/I73Ycb/MuHLtXh/4SuErxS+Svhq8j94zLaO
          "]]}, "Charting`Private`Tag#59"], 
       Annotation[{
         Hue[0.5980106724875895, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAUhqP1Io5uog5uuYNHEBQ3r+Ko4uDqETql4FSoUhAEwaFSKZWW
0iNI86c/9L0l/fjzvr4kw+V2seorpUZKqWZF1aaHj2BtqyLfoqZK8tRWYVxv
cDw09TOeYyw5c/gyM3BsddFX+FLh+whfwv3ofxs3eLC3+19i/id5Yv0PMpZY
9IfMx3b/lYzcJ+8sXzhve4Ntfkauu+yT5/CLPNRdX6zb+WaYn7zB+dh/wvnJ
Me5H+BLm7n611/GnzO94HzL+lwlfrsX7C18hfKXwVcJXM/8DcwS2iw==
          "]]}, "Charting`Private`Tag#60"], 
       Annotation[{
         Hue[0.8340786499873758, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRUdzEks7UQu7vYNHEBQ7r2KpYmHrEVJtwCqgEhAEwSISCZGE
kCNI9icfMtNMPn/m5e/uYLGZL/siMhSRuqMq28NHsHJVUt+udRXUE1e5bXaD
w76un/UajZbRBy+l73DXr+IlivehRos5j/23bYIHOzf/Uvmf1GPHf1CjRWo/
pD9y8xdq+D711umzyifS+if4pqt96hn4yg9NlxeZNt8U+anXOB/3jzg/dYT7
UbyYfnO/9MFPyL/jfTiP/6WKlxn1/sbr8HLug1coXql4Ff0/bcS2hw==
          "]]}, "Charting`Private`Tag#61"], 
       Annotation[{
         Hue[0.07014662748717626, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRUdzEks7UQu7vYNHEBQ7r2KpYmHrEVIlYBWIEhAEwSISCZGE
kCNI9q8fMtNMPv/Py+zuYLGZL/siMhSRtqOaoIePcGWrpr7GbVXUE1tl4GbD
w76tb+A5jVbQBy+nb3HxR/EyxXtTo6XMY/4VuMXDnc0/1f4P6rHl36nREjUf
0R/Z/IUavk+9tfqs9hP5+yf4pqt96hn4Rjp+ZLq8hP4U+1OvcT7yjjg//QT3
o3gp8+5+6YOfcf6G92Ee/8sVrzDq/Y3X4ZWcB69SvFrxGvo/a+S2hQ==
          "]]}, "Charting`Private`Tag#62"], 
       Annotation[{
         Hue[0.3062146049869625, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdUTEKwkAQXM1LLO1ELezuDz5BUOz8iqWKha1PSHUBq4BKQBAECyUSIgkh
T5DcxIHbbfaGmZ2b2+vNVtN5V0T6ItJ0VG07OEQLVxXx5dxUSTxyVdh2Ntpt
m/raoMVoOXn4ZeSd3fljxfNLld+bGO3F+zH/5PzG6R8q/5146PxvxGiJmo+J
B05/oh58SLx2+Kjyifz5A3jj45B4An8jHh8blY/8GPmJl3gf9Xu8n3yC/Ri1
P+rb/ZKHf8r5K/6HetyXqXy5Uf9vAs+voB5+pfKrVL6a/j9m1LaB
          "]]}, "Charting`Private`Tag#63"], 
       Annotation[{
         Hue[0.5422825824867488, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwlAQRFdvYmknamH37+ARBMXOq1iqWNh6hFQJWAWiBARBsFAiISEh
5AiSnTiQ3WYzzOz7+38Gi8182ReRoYg0HVX7PXwEK62K+ho1VVJPtAq/nQ0O
+6ZyarTM8FL6iou+vnR4ieF9DO9NHuZfnN9p/mnOe1CPlX+nRovNfEg90vyF
efge9Vb12ewn8vdP8F1Xe9Qz8J10/NCZ/ehPsT/1Gvdj/oj704/xPs68H/Pt
+9IHP+H8Df+HeZyXmv0yw8sNr6APXml4ldmvJv8HX4y2fA==
          "]]}, "Charting`Private`Tag#64"], 
       Annotation[{
         Hue[0.778350559986535, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwlAQRFdvYmknamH37+ARBMXOq1iqWNh6hFQJWAWiBARBsFAiISEh
5AiSnTiQ3WYzzOz7+38Gi8182ReRoYg0HVX7PXwEK62K+ho1VVJPtAq/nQ0O
+6ZyarTM8FL6iou+vnR4ieF9DO9NHuZfnN9p/mnOe1CPlX+nRovNfEg90vyF
efge9Vb12ewn8vdP8F1Xe9Qz8J10/NCZ/ehPsT/1Gvdj/oj704/xPs68H/Pt
+9IHP+H8Df+HeZyXmv0yw8sNrzC80uxfmf1q8n9fLLZ6
          "]]}, "Charting`Private`Tag#65"], 
       Annotation[{
         Hue[0.014418537486335481`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRcfcxNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsIhEQkJC
yBEk++OHnWkmn//n7exmuNwuVp6IjESk66g2GOAjXNtqqG9xVzX11FYV9LPh
8dBVSR+tULyceYuLv4E4vEzxPtRoKXmYf3N+b/Mvdd6TemL5D+bREjUfUY9t
/sp5+D71zuqL2k/k75/hG1f71HPwjTh+ZNz3S+jPsD/1Bvdj/oT700/wPoqX
UvfvazyHn3H+jv/DPM7LFa9QvJIavErxarV/o3gt/R9aHLZ0
          "]]}, "Charting`Private`Tag#66"], 
       Annotation[{
         Hue[0.25048651498612173`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRUdvYmknamG3d/AIgmLnVSxVLGw9QqoErAJRAoIgWCREQkJC
yBEk++OHnWlmP3/mzezuaLVbrociMhaRLiNavz8EGxuNP+j1Peqipp7ZqKhP
xy5KaqSCGrzc72cFFhd9OQ+8jD54KTVSQh76P+w/2Pq3mveinlr+k/VIseoP
qSe2/sZ++B79vdVXtZ/Iv/4C37jao16Ab8TxQ+O+X0x/jv2pt7gf68+4P/0Y
76N4iXH/KzVDh5+x/4H/YT3m5YpXKF5JDV6leLXav1G8lv4PU9S2cQ==
          "]]}, "Charting`Private`Tag#67"], 
       Annotation[{
         Hue[0.486554492485908, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRTfexNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsEiIhISE
kCNI5ocPO9PMfv7Mm9nd8Xq/2oyMMRNjTJ8RXTAcwq1EG3iDfsR9NNRziZr6
fOqjokYqqcErgmFWKLj4x3ng5fTBy6iRUvLQ/2X/Ueo/at6beib8F+uREtUf
UU+l/s5++D79g+ib2o8RXuFbz9E+9RJ869ZH1n2/hP4C+1PvcD/WX3B/+gne
R/FS6/5XZkcOP2f/E//DeswrFK9UvIoavFrxGrV/q3gd/T9SjLZw
          "]]}, "Charting`Private`Tag#68"], 
       Annotation[{
         Hue[0.7226224699856942, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRTfexNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsEiIhISE
kCNI5ocPO9NMHjPzZjc7Xu9Xm5ExZmKM6TOiC4aPcCvRBt7Aj7iPhjyXqMnn
Ux8VGakkw1cEw65QdPGP++DLWYcvIyOl9GH+y/mj9H/Uvjd5Jv4X+5ESNR+R
p9J/5zzqPusH4Zu6LyO8om49h33yEn7r9kfW9SWsL3B+8g73I19wf3KC/6N8
qXXfK7Mjx59z/on3YT/2FcpXKl9Fhq9Wvkadv1W+jvU/UFy2bg==
          "]]}, "Charting`Private`Tag#69"], 
       Annotation[{
         Hue[0.9586904474854947, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRTfexNJO1MJu7+ARBMXOq1iqWNh6hFQJWAWiBARBsEiIhISE
kCNI5ocPO9NMHjPzZjc7Xu9Xm5ExZmKM6TOiC4aPcCvRBt7Aj7iPhjyXqMnn
Ux8VGakkw1cEw65QdPGP++DLWYcvIyOl9GH+y/mj9H/Uvjd5Jv4X+5ESNR+R
p9J/5zzqPusH4Zu6LyO8om49h33yEn7r9kfW9SWsL3B+8g73I19wf3KC/6N8
qXXfK7Mjx59z/on3YT/2FcpXKl9Fhq9Wvkadv1W+jvU/UFy2bg==
          "]]}, "Charting`Private`Tag#70"], 
       Annotation[{
         Hue[0.19475842498528095`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRTe5iaWdqIXd3sEjCIqdV7FUsbD1CKkSsApECQiCYJEQCYaE
kCNI5ocPO9NMHjPzZjc7Wu2Wa98YMzbG9BnRhcNHtJFoQ2/ge9JHQ55J1OTT
sY+KjPQjw1eSRZd8uQ++IvQdX05GytT8h/MH6X+rfS/yVPxP9iOlaj4mT6T/
xnnUA9b3wld1X0Z0Qd16DgfkBfzW7Y+t60tZn+P85C3uRz7j/uQU/0f5Muu+
V259x19w/oH3YT/2lawP76t8FRm+Wvkadf5Wna+j/w9NzLZs
          "]]}, "Charting`Private`Tag#71"], 
       Annotation[{
         Hue[0.4308264024850672, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRSe5iaWdqIXd3sEjCIqdV7FUsbD1CKkSsArEsCAIgkUkEgwJ
IUeQnQkfdqbZ/fw/b2d3R6vdch0S0ZiI3CrVx8Mm2XB10PfMVRsHg55xNdCn
o6saeVl+8IVXQTMu+yIvvFLxPnHo8QrV/0b/gfMvdd4Tesr8h5rPqv4UesL5
G/rFj+DvWV/hk1/JRXwTeDqCXgjf+PnU+DwLfy7zQ2/lftBnuT+0lfdRvMKo
9zWhxy/Rn8v/IC/nVfCH/1W8Ws3bKF6r5u/UfD34f0a8tmg=
          "]]}, "Charting`Private`Tag#72"], 
       Annotation[{
         Hue[0.6668943799848535, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAYhdPexNFN1MEtd/AIguLmVRxVHFw9QqcUnApVCoIgOFQqxdJS
egOleeFB/rekj/fy9U8yWGzmy1ApNVRK9SvUGfcRr6xa+mvaqzGB8xOrmv6w
71Wxj+XLHLyS3uLSD/vgFYL3NqHHy8X+l/lBZmf7TzH/g/2x5d/FfBk99if0
I9u/cD/yiPnW+jNz5Ss+IdeB5yP6Gfja7yfa52XMp5iffo3z0R9xfvoM9yN4
uRb3q0OPX3D/De/DPv5XMnfvK3iVmLcWvEbM34r5OvL/ChO9Xw==
          "]]}, "Charting`Private`Tag#73"], 
       Annotation[{
         Hue[0.9029623574846397, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAYhdPexNFN1MEtd/AIguLmVRxVHFw9QqcUnApVCoIgOFQqpdJS
egOleeFB/rekr+/l6590sNjMl6FSaqiU6leoM+4hXlm19Ne0V2MC5ydWNf1h
3+vLPpaKOXglvcWlH/bBKwTvbUKPl7OP/S/zg8zO9p9i/gd5Y8u/s4/XGfvY
n9CPbP8i8oh+a/2ZfOUrPiHXgecj+hn42u8n2udlzKeYn36N89EfcX76DPcj
eDlzd7869PgF8xv+D/fje6X276/S4v+LeWvBa8T8rZivY/4HPJXLTA==
          "]]}, "Charting`Private`Tag#74"], 
       Annotation[{
         Hue[0.13903033498444017`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAYhdPexNFN1MEtd/AIguLmVRxVHFw9QqcUnAq1FARBcFAqpdJS
egOleeFB/rekX/+Xlz9/BovNfBkqpYZKqX6FOuM+4pVVS76mvRoTOJ5Y1eTD
vteXfiwV68gryTYu/dCPvELkvU3o5b3ox/6n+UFmZ/0P0f+deWObf6Mfv3P6
sT8hj6z/IuoReWv5zHzlKz6hrgOPI/IM+dr3J9rPy1mfon/yGvcjH3F/co75
kN38yG6+OvTyC9YzvA/7wXml9udXafH+ot9a5DWi/1bct2O/fzvdy0s=
          "]]}, "Charting`Private`Tag#75"], 
       Annotation[{
         Hue[0.3750983124842264, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRdfcxNJO1MJu7+ARBMXOq1iqWNh6hFQbsApECQiCYKFEQkJC
yAmM7Mz6Yec3m7/z9+3spD9fzxaBUmqglLIrqzXuI1qSGvhLYlWbnvNjUgW/
31mVyPNSCF6OPOGSD+rMywTvbQKP90Kezz/NtyOZLeUf4r47eCPi30zn8ryd
Is/nY/gh5c+iHsJvyJ/AV76iI9e170P9z0+ZL+qx9nkp6hPuH37F74M/8Pvh
U54PvJsfvJuvDjx+hvqV/4+4L9f+/ArBK0W/leDVgteI/lr4HzWty0U=
          "]]}, "Charting`Private`Tag#76"], 
       Annotation[{
         Hue[0.6111662899840127, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRdfcxNJO1MJu7+ARBMXOq1iqWNh6hFQrWAWiBARBsFAiISEh
5AQq2b9+2Jlm+fl/385MutPlZBYopXpKqfZENeaLMnNbtXHG8Ry3VZmO00Nb
JfV201bBPI6cGryMeYuL3/TBSwXvZQKP92Qe9x/m4/pd2/xdvHcjb2D5V86H
zwnzuB9R923+JPyQemX1gXzl13EPX/s61P/8GHzhR9rnJfRH6J96gfn0f54d
5qefYD/Ubn/Ubr868Pgp/Qv+j3gv0/7+csEr6INXCl4leLXor6H+AXM44C0=

          "]]}, "Charting`Private`Tag#77"], 
       Annotation[{
         Hue[0.8472342674837989, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdUTsKwkAUXL2JpZ2ohd3ewSMIip1XsVSxsPUIqTZgFYgSEATBQokEQ0LI
CVSysxnYN80yO+/N+/Vmq+m8q5TqK6WaF6jNDzALi8o4ITzHDUrTcXxkUVDf
bRvkzMf3hzr8MuZbu/hNHX4pdfi9jOstxPNkPPIf5uvqbWz8XdS7kQ+t/1X0
l1BHfkQ+sPEnoQfka8uP7Ff5CA/Qtc8D3cZP4C/0SPt+CfUx+idfYj7dzrPH
/NQT7Ifc7Y/c7Vd3Pf+U+gX3EfUyLe4r/HLd3gN+hfArhV8l+qvJ/0Cs5yI=

          "]]}, "Charting`Private`Tag#78"], 
       Annotation[{
         Hue[0.0833022449835994, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdUTsKwkAUXHMTSztRC7u9g0cQFDuvYqliYesRUm3AKhAlIAiChaKESELI
CVSysxnYN80yb96b99nudDmZBUqpnlKqeYHa/AAzt6iME6JT0qAkH1oU5NtN
g4/5unqEc+rwy0zHcWuXvIXfizr8nsbNFuF5MB/1d/Zb2/yb6HclH1j/C/dD
OKWO+pi8b/OPQg/JV5YfOK/yEe2ha5+Hus0fw1/osfb9UuojzE++wH663WeH
/amnuA+5ux+5u68OPP8X9TP+R/TLtH+/XPh9dPsf8CuEXyn8KjFfTf4HO/zn
IA==
          "]]}, "Charting`Private`Tag#79"], 
       Annotation[{
         Hue[0.31937022248338565`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAYhVNv4ugm6uCWO3gEQXHzKo4qDq4ewSkFp0KVgiAIDkqltLSU
nkClefFB/reEL+/PS/4/3elyMusopXpKqXaFGvOFzNyqNs4Iz3Grijy0Ksnb
TavCfNx5bOf0kZeZwLGNi98iL6WPvJdxbwuxPFmP8w/et7b1d3HfjTyw+Vf2
h+2EPs5H5L6tPwn/SF5ZPpCVr3APX/t8JI+RL/xIB15eQn+E95MX6E//+9mh
f3KC+bDezY/s5qs7Xn5K/4L/Efdl2p9fLvIK/f8P5JUirxJ5tXhfQ/4BlqPu
Fg==
          "]]}, "Charting`Private`Tag#80"], 
       Annotation[{
         Hue[0.5554381999831719, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb0KwjAUhdO+iaObqINb3sFHEBQ3X8VRxcHVR3BKwalQpSAIgoOiFIul
9AX8oTnpgdyzhC/n3pObpDWaDcehUqqtlKpXqDI/yEysSuOM6JDUKsg9qzd5
tayVm4/rx/aLPvIyso1LniLvYQIv727cbBGWm+i/mq87b2HrL+K8M7lr80+8
H7ZT+uiPyR1bvxf+jjy3vCUrX9EGvvZ5Rx4gXzfzwI914OWlrO9jfvIU92P/
Gvcnp3gf1rv3I7v31aGX/6B/xP+I8zL99f9X5OW6+X/kvUVeIfJKMV9F/gMc
V/UK
          "]]}, "Charting`Private`Tag#81"], 
       Annotation[{
         Hue[0.7915061774829582, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwjAYhaM3cXQTdXDLHTyCoLh5FUcVB1eP0CkFp4JKQRAEB0UplpbS
C1ileemD/G8JX17+lz/5O5PFeNpWSnWVUvUKleYHmZlVYZwRno61cvLAKiNv
1rVS83X12P7QR15CtnHHt8h7mZaX9zSutxDLQ9TfTeXuW9nzN3Hfldy3+Re+
D9sxfdRH5J49fxB+QF5a3pOVr3AHX/sckEfI100/8CPt58XkIfrn+TneR97i
/eQY/yPyHmT3v7rt5b/onzEfMu5LdOXPV+Slupk/8jKRl4u8QvRXkv9XhfwB

          "]]}, "Charting`Private`Tag#82"], 
       Annotation[{
         Hue[0.027574154982758614`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkU0KwjAQhWNv4tKdqAt3uYNHEBR3XsWligu3HqGrFFwVqgQEQXBRqRSl
pfQC/tC89EEym/DlzbyZZLrT5WQWCCF6QojmRNTqh1BzE5WyQnRKmijJQxMF
ebtp4q0+th7XL+rwy8nGLnl6fpnqOH4PZWeLcKScD/V39bW8Nvk3r9+VPDD+
F9bjWlNHfUy9b/KPnh6SV4YPZOFGtIcuXQ7JY/jLth/0WLp+mjzC/Mxf4H2y
ff8O76eu8T+eX0rd/q8MHP+M+Wfsh4x+OfvZ/VK3+5ft/uFXeH6l51d589Xk
P6DlEPc=
          "]]}, "Charting`Private`Tag#83"], 
       Annotation[{
         Hue[0.26364213248254487`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAViCAiCYBGJBENC
yAH8I/s2D3Zfs3w7M29mdnuz1XTeFUL0hRDNCdXqB6mFVqVMwD+HjUrySKsg
77aNcvUx9bh+OX4Z87Vd+HT8UtWx/B7KzObjSOiH+rv6Gt7o/Bv90O9KHmr/
C+txHZNRH5AHOv/EesQ98lrzkSxs+QfEpc0eeQJ/2fZDPJC2X8z4GPOTl9hP
tvvvsT/jMd7H8UsYN+8r2/eFf8r8CP9DRr+M/cz/On65fFvzFo5f6fhVznw1
+Q8GKSzW
          "]]}, "Charting`Private`Tag#84"], 
       Annotation[{
         Hue[0.4997101099823311, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkj8KwjAYxaM3cXQTdXDLHTyCoLh5FUcVB1eP0CkFp0KVgiAIDpVKsbQU
D1BUmpc8SN4Sfnn5Xr786c1W03lXCNEXQrQj9FE/SC20amWM8By3qsgjrZK8
27YqVGPqMf328nKyjotfXl7m5T1VxzCG1Kt/qK/hjV5/Zz32u5GHOv/Kekwn
ZNRH5IFef2I9/IC81nwkC1fhAb50OSBPkC9t//Aj6eYl0vYzRv/kJc7H+j3O
Tz/B/Xh5KX1zv9LeL/Izrr/gfcjYL+d+5n29vEI2Tr8lfeRVXl5N3/w/9vsH
9LVBuQ==
          "]]}, "Charting`Private`Tag#85"], 
       Annotation[{
         Hue[0.7357780874821174, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkj8KwjAYxaM3cXQTdXDLHTyCoLh5FUcVB1eP0CkFp0KVgiAIDpVKUVqK
B6h/SF76IHlLeXn5ft+XpJ3JYjxtCyG6Qgj9hd7qB6mZUaVsEB5jrZJ+YFTQ
b9ZaL1Xbeiw/1dfh5eQbXPygBy/zeHfVsh6f1Ku/kb8y+6+sR78Lfd/wz6zH
ckKP+oi+Z/YfvDygXxq/J1+4CnfIpesD+hH4spkfeSRdXiKbfkPMTz/H+Vi/
xfmZJ7gfj5cyt/crm/sFP+P+E96HHv1y+XHfl/3t+8vambdgP/BKj1cxt/8f
5/0DVV5Wng==
          "]]}, "Charting`Private`Tag#86"], 
       Annotation[{
         Hue[0.9718460649819178, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkjsKwkAQhldvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgpIQ
PEB8sPtvftidZvkyM9/sI53JYjxtCyG6Qgi9It7qh1AzE5WyifAY6yjJAxMF
6zdrHS9VW0bZU30dX856o4sfZPgy+uG7q5ZlLKnXf6N/Zeqv7Me8C7lv/Gf2
43NCRn9E7pn6g5cPyEvDe/qFG+EOeelyQB7BL5v9Ix9J15fIZt4Q+yfPcT72
b3F+5hPcj+dLmbf3K5v7hT9j/Qnv483L5cd9X8637y9rZ78F++ErPV9Ftv8f
+Q/q+nJ+
          "]]}, "Charting`Private`Tag#87"], 
       Annotation[{
         Hue[0.2079140424817041, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgiEh
pPeX7Ns82H3N8u3MvJnZ7UwW42lbCNEVQtQnVKkfpGZaJfkY1iqUSfQHWjnj
m3WtTL0NI+2pvpZfStZ24YP18EvoD7+7ahnGETv1N/JK519Zj34Xcl/7n9kP
1xEZ9QG5p/MPTtwjLzXv6S9s+TvEpc0eeQR/2cyPeCCd+chDzE+eYz/5MbzF
/oxHeB9pzxezn3lf2bwv/BPWn/A/Tr+U/cz/On6ZfFnz5o5f4fiVzr4V+Q+/
2odh
          "]]}, "Charting`Private`Tag#88"], 
       Annotation[{
         Hue[0.44398201998149034`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgpIQ
0sc/sm/zYPc1y9uZ+WZmtzNZjKdtIURXCFGfUKl+kJppFfTHsFauTKI/0MoY
36xrvVRlPNKe6mPxUvU1XuPCB+vBS8gH765axuOInfob+Sudf3Xmv5DX1/wz
47iO6FEf0Pd0/sGJe/RL7ffkC1v+DnFpe49+BL5s9kE8kM589EPMTz/HfrLZ
f4v9GY/wPtKeL2Y/876yeV/wE9af8D9Ov1S+7f9lf/P/srLmzRxe7vAKZ9+S
/g8OYY5U
          "]]}, "Charting`Private`Tag#89"], 
       Annotation[{
         Hue[0.6800499974812766, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamG3d/AIgmLnVSxVLGw9QqoNWAWiBARBsIhEgpIQ
0sc/sm/zYPc1y8fMvPnZzmQxnraFEF0hRP1CpfpBaqZVkI9hrVyZRH+glTG+
Wdd6qcow0p7qY/mlZG0XPlgPv4T+8LurlmE8sfpa9Tf6rXT+1Zn/Qu5r/zMZ
fhEZ9QG5p/MPTtwjLzXvOa+w5e8QlzZ75BH8ZbMP4oF05iMPMT95jv1ks/8W
+zMe4T7Sni9mP3Nf2dwX/gnrT/gfp18q3/b/sr/5f1lZ82aOX+74Fc6+JfkP
8jqVSw==
          "]]}, "Charting`Private`Tag#90"], 
       Annotation[{
         Hue[0.916117974981077, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb0KwjAUhaNv4ugm6uCWd/ARBMXNV3FUcXD1EZwiOBWqFARBcKhUSqWl
dG/9oTnJgfQu4eOee3Ju0pksxtO2EKIrhKhPVKF+KDXTlZPPfl2ZMsLjQFfK
/mZd11uVhiFLVOX4xepjWNv5L87DL6I//J6qZRhHqL7O/IN+K62/s4/7bvTv
a/8rGX4BGfMe53tafyKjfyAvNe+Z176g9duhL20ffCCP4C+/jt6TjXzkIfJT
P8d+0u6/xf7UB3gf6eYLOW/eV9r3hX/E+Qv+h4z7Ylk5+RKy+X9ZOnnThl/W
yJ839i3If8HNnDs=
          "]]}, "Charting`Private`Tag#91"], 
       Annotation[{
         Hue[0.1521859524808633, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdUbsKAjEQjP6JpZ2ohd3+g58gKHb+iqWKha2fYBXB6kBFEATBQjk5FI/D
2tfJZZKBZJswzOzs7KbSGbS7ZaVUVSlVvKin/uWmdM9UpnOLN+uiUm2Fy4ap
B/nJuKi7flsM2U1/PL+E2Nitr+yHXxz4XXTJzsNzZj70n/TX4pHRH4P8B/rV
jf+ePPx25NEfka8Z/YoY/IJ4aPCc93AXdH4z8OJ44IU4vgV/+Xn6iLzNR9xE
fur72E/c/lPsT/0O9xE/35n99r7i7gv/mPwW/0M/zEsk+F/5eH53eXl5H4Ff
GuTPgn2fxH/IB6ok
          "]]}, "Charting`Private`Tag#92"], 
       Annotation[{
         Hue[0.38825392998064956`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhVdvYmknamE3d/AIgmLnVSxVLGw9QqoVrAIqAUEQLBRFFEVS
x5hI9u0+2EyzPN7sN3+13qjbryql6kqp4kXEOstN6IGJj86t3m6KeGubuGqZ
eDF/Ni3iqROrkfbQqce7Uxvc5kY+eFdq8C66YuvhObMe/p/0z+qJyT+W+j+Q
1zT8PX3wImr8D6kbJn9d8gPqsdFL7sNt0NVbwBfnQwfi/A74knn5IX3bH/02
+qceYj5x888xP/9H2I/4/Z3Fv9dF3H7Bv9Lf4T7kod5dvv59JfV4T0m8fl8l
3pv9gvcpzRtT/wHAr6of
          "]]}, "Charting`Private`Tag#93"], 
       Annotation[{
         Hue[0.6243219074804358, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KAjEQhQdvYmknamE3d/AIgmLnVSxVLGw9glUEqwUVQRAEC5cVURSx
9mdXNi/7IJkmPF7yzZtMud1vdUoiUhGR/ES9TJrZMl1bT5M5vV7l9aCu27rz
/niU1828nQbvar4e70JtcatzwEuowYsdRxY4TuyH90fzc3po7x+C/Hvyapa/
ow/elhrvI+qqvb8M/Dn1wOpZkE+k6DeFr76eUzfB19TzI/ouH/0G8lP3MJ8W
808wP/0t/keD/1N/XzF98BP6G+yHedDvoh9/v/r1eDd9e3nvAe/BvOA91d/H
i/P/AdfuuAs=
          "]]}, "Charting`Private`Tag#94"], 
       Annotation[{
         Hue[0.8603898849802363, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KAjEQhQdvYmknamGXO3gEQbHzKpYqFrYewSqClaAiCIJgscvKoiiy
taw/7Lzsg2Sa8HiZL28y1e6w06uISE1EihOV2e9Py/a1XtS7bVFP+3O6qfWg
P50Udbdvp8G72dzjpdSK217ZD15CPnix48gKR8T76L/Yj9NjvX8O8p/Iayj/
SB+8AzX6N9R1vb8O/CX1SPUiyCdSvjeHb3y9pG6Db76ev6Hv8tFvIT/1APOZ
cv4Z5qd/wP8EvMj4+4pNmR/8hP4e+2E/3ktNsF+Te7w7ffAeAe/JvOC9jL+P
jHn/wJ2/AA==
          "]]}, "Charting`Private`Tag#95"], 
       Annotation[{
         Hue[0.09645786248002253, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KAjEQhQdvYmknamE3d/AIgmLnVSxVLGw9glUEK0FlQRAEC2VlURSx
9F/ZvOyDZJrweJkvbzL5ervWyIlIQUTSE3Uz358t07R1pV7M07qYn9NlW2f6
/V5aJ/NwGryjeXu8xLyctrj5gf3gxeSDt3ccmeDY8T76t+bjdNfe3wT51+SV
LH9FH7yIGv0z6qK9Pw38MXXH6lGQTyR7bwhffT2mroKvX8+f0Xf56FeQn7qF
+TSbf4D5qSP8T8Dbqb+vvWb5wY/pL7Ef9uO9RJ/+fvXt8U569/KeA96F+cC7
qr+PG/P+AbrVvvs=
          "]]}, "Charting`Private`Tag#96"], 
       Annotation[{
         Hue[0.3325258399798088, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KAkEMhYM3sbQTtbDLHTyCoNh5FUsVC1uPsNUIVoKKIAiChaKIsotY
Lv6z82YfzKQZHkm+vEyKzW6jVRCRkohkL+Jhvj8bpm3jTr1cZJGYn9NVGzHz
w0EWN5M6Dd7VvD3exbyctrjFmf3gncgH7+g4MsVzYD369+bjdN/W7wL/W/Iq
lr9hHrw1Nfrn1GVbPwvyEXXP6kngTySfN0ZefR1p3l8HXz9efq6BP+oa/LO+
g/00/98R9md+jf/hfPd/6t/rqLl/8E/sX+E+rMe8iz79+3K+u7+mnt+Y/eAl
gf97sO+Dfv+yhb7z
          "]]}, "Charting`Private`Tag#97"], 
       Annotation[{
         Hue[0.568593817479595, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uB27+AjCIqbr+Ko4uDqI3SK4FRQKQiC4KBUiqWl
dCzWWmku+SG5JXzc3ZfLpT2ejyYtIURHCNGcHLn81SrkVEUGPh2bSMF9FYms
NK9XTcSy0My+tywtXwRWuuPL8YWytnxP7RF7Ph6o5/477l+q+psz/xW+nvJf
kGdfAOZ+H9xV9Qcn74EXinfwmw0a3nKebPbI9A/ZT5WV98mZDzzg+VE/4/fR
V/OG3498wPvB/Xp/8On9ktkv+0P0n/l/UM/3RfSx/5dKyxdTYc2boJ99qTN/
5rw3x7x/9BjF5w==
          "]]}, "Charting`Private`Tag#98"], 
       Annotation[{
         Hue[0.8046617949793813, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTsKAjEURYM7sbQTtbB7e3AJgmLnVixVLGxdglUEK0FlQBAEC0WRGWYQ
Sxm/TG5yIXlNOLzkvE/K7X6rU1JKVZRSxYl46O/PhO6auJM36yIyct1Eqj+W
x6MiEv20DF+sX57vpnPLRre+Br6L/nm+s/WoBY4T6+H9kTw09w9k1NvTVzP+
HevBF5HxfkWumvvLwD8nDwzP6HcbdDxFXnyei/M34ZePl19J0B+5gf55v4f5
5G15gvmZj7Af1rf7E/+/zuL2C/+F+S3+h/VR7ya554vl5fkSeXr9pnwPXxb0
fw/mfbDfP+q4xeE=
          "]]}, "Charting`Private`Tag#99"], 
       Annotation[{
         Hue[0.04072977247918175, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KAjEQRoM3sbQTtbCbO3gEQbHzKpYqFrYewSqClaCyIAiChcvK4qKI
pf/K5ks+SKYJj8m8mUyKzW6jVVBKlZRS+Ym46e/PhG6buJJXyzwu5KqJs/5Y
Hg7yyPTdMnwn/fJ8qX5aNrrlMfAl+uf5YutRMxwH9kP9ntw393dk9NvSVzH+
DfvBF5FRv2B92dyfB/4puWd4Qr/boOMx8uLzVFy/Ovzy8fILCeYj1zA/73fw
PnlbHuH9zEfYT+A7iP9fsbj9wp8wv8b/sB79Unn4/ysvz5fJ3Zv3zHr4LsH8
12C+G/f1B+gQxd4=
          "]]}, "Charting`Private`Tag#100"], 
       Annotation[{
         Hue[0.276797749978968, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkc8KQUEUh0/exNJOWNidd/AIiuy8iiWysPUIVqOsFLqllLIgEpHs/Hd1
5zf3VzNnM32dc75zZiZbbVZqGRHJiUhyIm7mF9swdRtX8myaxMV8HRdtnMnd
ThIn83AM39G8Pd/BvBxb3XRPP3w7Mnxb55ERjg3noX9Nbtv6FRnzlvQVrH9B
hi8io3/C/rytHwf+IblleWBizyeS+vrIa+zxUNN8GX79evmJBvuRS9if9Q3c
Tz+Oe7g/8xHeJ/Bt1P+vrabvC/+O+Tn+h/2Yd9Cn/7/69nwnvXv7ntkP3yXY
/xrsd+N7/QHgWMXZ
          "]]}, "Charting`Private`Tag#101"], 
       Annotation[{
         Hue[0.5128657274787543, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamG3d/AIgmLnVSxVLGw9gtUWVoKKIAiCRUIkRAwh
XQhRI9m/fphMEx5/581stjmcDkYNpVRLKVV9Uan5lrbM2FZCPh6qis3HcdfW
i7xcVPU0mWP4IlMIX2hyx1Z3eNAPX0CGzzel8Hmch/47eW7P38iYd6WvY/0X
5vCdmaN/z7xtz+9q/i15ZnlT20+pv2+NXJeCt/qf9+HXH5Hvmbv9yD3sz/MT
3E+/Ha9wf+Zn/J+az9PyvXzuB3/A/IT3YT/mhToXvkgXwvfUmfC92A9fzH3h
S2r7peQfjNbTxA==
          "]]}, "Charting`Private`Tag#102"], 
       Annotation[{
         Hue[0.7489337049785405, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamE3d/AIgmLnVSxVLGw9gtUWVoKKIAiCRUJEFEVS
BULUSPavHybThMfMvJnJVrvDTq9ijKkZY4ovIrbf3IXtu3iRt5sinvbjueni
QZ5OirjbxDN8N5sp39Wmnp1ucyn5Is6DL7S58gWsR//Zvj2PXf2JjHlH+hrO
f2A/fHsy+tfkuqtflfJL8sjxorSfMf95c+RF85Lchl8+Kr9m3u/HfAv7kwe4
T/73znA/83v8H9H3BqLfK5Rc+SPmd3gf7oN5V0mV7yaZ8t0lUb4H++F7cl/4
XqX9Yt7/A3/207o=
          "]]}, "Charting`Private`Tag#103"], 
       Annotation[{
         Hue[0.985001682478341, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uCWd/ARBMXNV3FUcXD1ETplcCpUKQiC4NBSKZWW
0qVDQa00f/tDckv4uLsvd0l/vp4tekKIgRCiORGF+tU61FJHrr4tX7wmMvVp
eawjZX6/a+KtypbhS1Rl+GKy1nkv9sMX8X74QlUbvoD16H9ynq2uf5Bx352+
kfbf2A+fT0a/Sx7q+rOVd8gbzSf6uxfs+Ii8NNmRXf8UfjLyrrTmI08wv+z2
W2E/8gH7s97H+1i+QJr/Fcra8EfMX/E/ZNwXy8rwJeT2/2Vp+FLuD19mzZ9b
8xWs/wNuftOt
          "]]}, "Charting`Private`Tag#104"], 
       Annotation[{
         Hue[0.2210696599780988, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KAjEQRoM3sbQTtbCbO3gEQbHzKpYqFrYewSqFlaAiCIJgscvKoiiy
xTbiz8rmSz5IpgmPmXkzSardYadXUUrVlFLlicj0rzCh+yae+mt5uynjoT+W
mybuzE8nZdx0bhm+q355vpRsdJsL++FLOB++WBeeL2I9+s/cZ2zqT2TMO7K+
YfwHMnx7MvrX7K+b+lWQXzI/Mrzgvu4FHc+RF5+X4nxt+MnIryXYj9zC/uLm
D3A/eVue4f7M7/E+gS8S/79iKTx/wvwO/0PGvFRenu9Ktv8vuee7B75HsP8z
2C/je/0BZW7TpQ==
          "]]}, "Charting`Private`Tag#105"], 
       Annotation[{
         Hue[0.45713763747789926`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrIQoAUEQLBIioiSI
RZrgTyT7Ng8204SPmfftbLY5nA5GDaVUSylVflEv/StM6bGpp/5a3vtlpfpj
uWsqYX+5KOuhM8vw3XXu+G5ko/OvzMMX83z4Il04vpDzyF/02/LczJ+5H847
cb5j/EcyfAEZ+R3zbTO/JaPvkWeGN9y3+oMVr9EXlz2p8n345ev0d1Lbj9zD
/sxPcD+p7r/C/dkP8H9qvlDc94qkcPwx8we8D+dx3k1yx3cn2/eXzPElzMOX
1vZ/1vZ7kf9gZtOg
          "]]}, "Charting`Private`Tag#106"], 
       Annotation[{
         Hue[0.6932056149776997, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uB27+AjCIqbr+Ko4uDqI3TK4CSoCIIgOCiVolhK
hy6itdL86Q/JLeHj7r5cLvX+uDeoKaUaSqnyRKT6V5jQQxOJzi3vtmXE+mu5
beJFns/KeOrMMnwP/XZ8EdnotnfPF/I++G66cHxX5tF/0R/LU1N/pg/3nVjf
Mv4jGb4DGf0b9jdN/ZqMfECeGF5xX9UGK14iLy4HUvV34ZfcyW/Em4/cwfzs
H+F9Ur1/gfczf8B+PN9VvP1K4fhD9u/xP6zHfZG8Hd+DbP9fMsf3Yj98sTd/
4s2Xkv9Z7tOd
          "]]}, "Charting`Private`Tag#107"], 
       Annotation[{
         Hue[0.9292735924774718, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamG3d/AIgmLnVSxVLGw9QqoprAQVQRAEC0UJCRGx
EBLwJ5J9mwe704SPt/PN7KbaHXZ6FaVUTSlVfFFP+eampG/qQd6si7rLx3LT
VEKeToqK5WUZvkhSxxdKZtno1jfPd+U8+C6SO74zc/Sf5G15bM4f6cO8A7lh
/HsyfDv60L9iXjfnl2TkAXlkeCE/x6dUyXPk+utwoMv+NvxeviLb/cgt7M/+
Ae6ny/vPcH/mO7yP5ztr73117viv7N/i/3jzQp05vkinji/WL8eXcB58d+4L
38Pb70n+A0p+05E=
          "]]}, "Charting`Private`Tag#108"], 
       Annotation[{
         Hue[0.16534156997727223`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLJRISEgI
gRQJaKJkZ/PB7jThMTtvftKdLiezjhCiJ4RovhyZrH4q5FxFCj55TSTyq3mo
IgZvN01EMtfMvlAWhi+QpWal896Wz0c/9r1kbfieyHP9Q340r9X7O3zc7wYe
KP8VzL4LmOtdcF+9P1p5B7xSfLDmE6LlPeepMtihtn7MfjDnXbLmA494fvCC
96N2/x3vj/yF74P++n5k3Zdqw++j/sz/x+oXUGn4QioMX0S54YstX4J52Zda
82XgP0B204g=
          "]]}, "Charting`Private`Tag#109"], 
       Annotation[{
         Hue[0.4014095474770727, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9gtUWVgEVQRAECyUiiiEE
AkFQo2S/zQe704TH7Lz5SbU77PQqSqmaUqr4IhL9/ZnQfROx/ljerIuIyE0T
T/J0UsRDp5bhu+vM8d30y7LRra+eL2R/+C46d3xn5lF/0m/LY/P+SB/6HcgN
49+T4duRUR+Q6+b9yssvySPDC28+pcr55siLy0sp69vwk5EPxJuP3ML8Uu47
wH7kGfYn73Af9rf3E+++kjv+kPVb/B/2R7+bvBzfXTLH95DU8T1ZD1/kzR97
8yXkPzfu04E=
          "]]}, "Charting`Private`Tag#110"], 
       Annotation[{
         Hue[0.6374775249768447, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb0KwjAURoNv4ugm6uCWd/ARBMXNV3FUcXD1ETrdwalQRRAEwaFSKZaW
UihU8adKc9MPkruEw809+ZI0h9PBqCGEaAkhqpUro89PFY1VpeCdV1VCb81d
VTH6y0VVEeWa2XenwvCF9NSsdN7N8gX0NXxXKg2fjz7PX+ilea72n638J3BH
+Y84j30HMM+74Lbav8U89x3wTPHGyidEnW/NfWmyI+v5PvvB3HfBOp+s8/Q4
P3jC9wOv+P7gA7+P5fOl9b6yNPwB5vf8P5jn80L5MP9XFoYvkrnhizHPvsTK
n1r5MvAfKA7TdQ==
          "]]}, "Charting`Private`Tag#111"], 
       Annotation[{
         Hue[0.8735455024766452, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamG3d/AIgmLnVSxVLGw9QqoprAJRBEEQLCKRkJAQ
QiAE/Cc7mw92pwmPmXk7M2mP56NJSwjREULUX46c3j8VNFWRgQ9eHSm9NPdV
JMivV3XEVGhmX0Sl4Qup0qx03sPyBfQxfHf6Gj4fee6/0VPzUtVfrfkv4J7y
n/Ee+05g7nfBXVW/Rz/nHfBC8Q7zNBdseMt5+TbYkY1/yH4r74L1fKgf8Pzg
Ge8nm/03vD/yJ76P5fOldV/5NfwB+o/8f9DP74WyMnyRLA1fLAvDl6Cffak1
f2bNl4P/HDbTbA==
          "]]}, "Charting`Private`Tag#112"], 
       Annotation[{
         Hue[0.10961347997641724`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamG3d/AIgmLnVSxVLGw9QqotrAJRBEEQLCKRYEgI
IRAFTVAys/mwO014zMzbv5v2eD6atIQQHSFE/eXKVPmjUlOqVH01H7y6EnCf
Ksb8elVXpHLN7HuqwvCF6q2ZdN7D8gWW764qw+ejz/s39dG8pPmrlf8C7pH/
jPPYdwLzvgvu0vwe+9x30F8Q76x8QjS85b4sDXZkk3fIfqvvgnU+2Zw34Pzg
Gd8Pvg3fH/0Tv4/l86X1vrIy/AH2j/x/MM/nhfJl/l9ZGL5I5oYvxj77EuRl
X2rly8B/D3bTYg==
          "]]}, "Charting`Private`Tag#113"], 
       Annotation[{
         Hue[0.3456814574762177, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwjAQhoNv4ugm6uCWd/ARBMXNV3FUcXD1ETplcCpUEQRBcKhUiqWl
lEIVtEVpLv0hd0v4uLvvLkl7PB9NWkKIjhCiPikyVf50qKmOVH0NH7w6EnBf
R4z69aqOSOWGyfdUheUL1duw1nkP5guY764qy+cjT/039TG81PVX+GjeBfU9
7T8jT74TmPpdcFfX71neAS8079h+QjS8pbwsLXZks++Q/Czvgs1+spk3oP3R
P6P7gTd0f9Sf6H2Yz5fsfWVl+QP4jvQ/qKd5oXzZ/ysLyxfJ3PLF6CdfwvZP
2X4Z+A8KxtNe
          "]]}, "Charting`Private`Tag#114"], 
       Annotation[{
         Hue[0.5817494349760182, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAUhBdvYmknamG3d/AIgmLnVSxVLGw9QqotrAIqAUEQLCKRYEgI
IQQFf1CykwzsTrMM89733u42h9PBqCGEaAkhyhPK1OenpcZaqXpXfr8rldB3
tWLWLxelIpVXHry7KgxeqJ6V17jdTb0MXmDxrvTg+ZyP/gv757r+zBzzTuzv
aP6ROXgePfpd+rau31q5Qz/TfqO+Bk+Iet4auTS9I+t9++BbuSvN+3qyntfD
/uyf4H70K9yf9R7ex+L5zKv3ZQ5+QN4B/8N6zAvlw/xfWRi8SOYGL2Y/eIm1
f2rtl9H/Af7301Q=
          "]]}, "Charting`Private`Tag#115"], 
       Annotation[{
         Hue[0.8178174124757902, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrIQoAUEQLBRFFEUU
guIfSvYlD2ZfEx4z75uZbL7erjVyxpiCMSb5Qlf7+TnZptPFvlM/DROd6ctO
J/p+L9HR3lIP3sHGire3j9Q7XLizL8Xbcj54G3rw1pyH/Ir5rutfso55C+ZL
jj9nHbyIHvkJfdH1j716QN9xfmS/imdMNm+IuryVDyTbtwq+6P6J6Hsj5ivY
n/kW7pNn6ge4n/UI/8fjrUW/14Z18LfMz/A+7Me8vdz1+0qseEe5Kd7J4529
/S/eflf6P/b/000=
          "]]}, "Charting`Private`Tag#116"], 
       Annotation[{
         Hue[0.05388538997559067, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrIQoAUEQLBRFFEUU
ouAfSvYlD2anCY+Z972ZbL7erjVyxpiCMSb5oq7283Nlm64u9p3qaZjUmbrs
6kTd7yV1tLdUg3ewseLt7T3VDhfu7EvxtswHb0MN3pp58K/o77r5JfvIW1CX
HH9ODV5EDf+Euujmx14/YF7H6ZH9Kp4x2b5D9OWtdCCZvwq+6PmJ6Hsj+ivY
n/4W7pNnqge4n/0I/8fjrUW/14Z98Lf0z/A+nEfeXh76fSVWvKPcFO/k8c7e
/hdvvyvz/u+H00g=
          "]]}, "Charting`Private`Tag#117"], 
       Annotation[{
         Hue[0.28995336747539113`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRgdvYmknamG3d/AIgmLnVSxVLGw9gtUWVoEogiAIFgmRkKBI
Alr4h5KZ+MHsNOHxzbydzVa7w06vQkQ1Iiq+Upl9fblsn+sKXvtFXcBNrjN4
OikqtXnJ4kvsTfliey+Zdf7JPpUvsm/lC8HiC3CezB8xP+b+A1jO26O/wf4d
cvFtkcu8h7zO/SsnXyIfMS/sR/mI/vvOJTcvxUvzn2+L38k9cLkfuCX7Y34g
9zOPkmdyf+Rb+T+OLzD6vULzVv4Ivo28D/rlvNjclS8xN+VLTa58Z+wjvouz
/9XZLwP/AOQn0z4=
          "]]}, "Charting`Private`Tag#118"], 
       Annotation[{
         Hue[0.5260213449751632, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRQdvYmknamG3d/AIgmLnVSxVLGw9QqotrAJRAoIgWEQiwZAQ
AtFCE1Gys/mwO014/Jm3s5v2eD6atIioQ0T1lyuX5U+VnKrK5EfzwasrBfdV
Jehfr+qKZa6ZfQ9ZGL5IPjUrnXe3fKHlu8nK8AXo5/kreKn6L2A+7wxfT/lP
yNnnI+d5F3lX9e+t3EG+ULyTX8NH1Oy75VyUBjvirXnIfit3wXo/8ID3x/yM
7wfe8P1Fs5/P72P5AuT6fUVl+EP4jvx/0M/nReJl/l9RGL5Y5IYvwTz7Umv/
zNovB/8B0LfTMA==
          "]]}, "Charting`Private`Tag#119"], 
       Annotation[{
         Hue[0.7620893224749636, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamG3d/AIgmLnVSxVLGw9QqoprAJRAoIgWEQiwZAQ
AlFQE1Cys/mwO014/Jm3s5v2eD6atIQQHSFE/eXKqfypoqmqjL6aD15dKbiv
KkH/elVXTJlm9j2oMHwRPTUrnXe3fKHlu1Fl+AL08/yVPpqXqv+CnM87w9dT
/hNy9vlgnnfBXdW/xzznDvKF4p21nxANbzmXpcGObPYdst/KXbDeTzbnDXh/
zM/4fvKtecP3R7/P72P5AuT6fWVl+EP4j/x/0M/nRfJl/l9ZGL5YZoYvwTz7
Umv/zNovB/8BxP/TJw==
          "]]}, "Charting`Private`Tag#120"], 
       Annotation[{
         Hue[0.9981572999747357, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRAoIgWCiRYMgP
CSj4E1Cys3mwO83yeG++nZ1tDqeDUUMI0RJCVCdXLr8/VXKsKpMfrXdeVQl0
V1WM/HJRVSRTrZl3l4XBC+VDa4XzbhYvsHhXWRq8C/Lcf5Zvrecqf4LP9x3B
6yj+AT7zfGjud6HbKr9FP/sO/JnSG2s+Ier8mn0ytUP1vH3mW75L1nzQPZ4f
/RN+H720XvH7kfd5P+Dr/cHX+6XS4Afg7/l/kOf7Qnqa/0uFwYsoNXixxUus
+TNrvhz6D7rH0x4=
          "]]}, "Charting`Private`Tag#121"], 
       Annotation[{
         Hue[0.23422527747453614`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLJRIMOSH
BRE0BpTsbD7YnSY8ZvbNt5vmcDoYNYQQLSFE9eVS8vvTJce6clkY3gVVpeCu
rgTzy0VVscwMs+8hleWL5NOw1gV3xxeC2XeTpeW7os/nL/JjeK7nz+jzvhPy
dbT/iD77DmA+74Pben7r9D3wTPPGySdEvW/NfbLZozpvn/1UWH2fnHzgHufH
+Qnfj96GV3x/zB/4fbDfvB8570ul5Q/h3/P/wTzvi+hl/19Sli+mzPIlji91
8ufOfRXy/gGxX9MX
          "]]}, "Charting`Private`Tag#122"], 
       Annotation[{
         Hue[0.4702932549743366, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhQdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRAoIgWCiRYMgP
CyJoFJTsbAZ2XrM83sy3M7vN4XQwagBACwCqk6RV+TNSY6NCva3fBZUyzrtG
KfvlolKicuuJd1fa4cXqYb3BBTfBiwTvqj4O78I59Z95vrmpP4n5j9zfMfwD
58QL2VO/z75t6rci99jPjN+or8MDqO9bU46u97Cet098LJ3cRzEf+x7Nz/0T
2g9f1q9of64P6X1QvB+K9+Wc+BHz9/Q/XE/3xfh0/xe1w0swd3ip4GVi/kLs
q9n/Aadv0xE=
          "]]}, "Charting`Private`Tag#123"], 
       Annotation[{
         Hue[0.7063612324741086, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb8KwkAMhw/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4CRUKQiC4KBUimIp
BRH8B0ov1x/kshwfyX1J7qrdYadXMcbUjDHFKZHz+2eD+zYyfjleh0Wk4KaN
G+qnkyKunDoW34Vz5Uv47tjqwrPniz3fiT/Kd0Re7h/46Xhs6/fe/Dtww/q3
6Ce+CCz3V6iv2/olWPIBeGR5wV/lM6acdy550hxQ2a8tfnqr/Ars5kN9S+YH
D2Q/Kvefyf64H8n7kPd+5L0v8uKP4d/I/6Be+iX00P9LufJdKVW+m+dLMa/4
MtL/kWP/P5hX0wY=
          "]]}, "Charting`Private`Tag#124"], 
       Annotation[{
         Hue[0.9424292099739091, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb1qAlEQhS95E8t0QVOkm3fIIwQUO1/FUkOKtHkEqymsFlZZEATBIrIi
kV3kElLoRlD2nrsHZqe5HM7Md+en8zZ67T845x6dc/WL8FrdQuggxEkvUS/S
OkrqXoiC+e/TOo5aRg3ej3rDO+hv1AGX7lu8vMXb6b/hfdNH/VbPUU9C/oY8
/LdmfjfwV/TBy6hRn1A/hfw56+HPqMdBf+nV8Jxr+v2EL1bPpOG/gC+V8RPq
2B/zn9E/9RDzSTP/B+ZnfYb9SGt/0tovffBz8pa4D/Px30H+7H3FG95RCsMr
2C94JfngncTew3P+O5Gn0wA=
          "]]}, "Charting`Private`Tag#125"], 
       Annotation[{
         Hue[0.17849718747368115`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbFqAkEQhpe8iaVdiCns5h18BCFi56tYRrFI6yNcNUUqQUUQBMEiYjg8
7jiOpIlnIOH23/thdprlY2a+ndntDCeDlwfnXNc515yISus/HzryUeot8Gbd
REHu+chZP581kWkeGL6rVsaX6ldgr1t/Rr4LGb6z3o3vg/eh/6Q/gV99/ZH9
uO/A+ifv3zMP346M/hX50de/sx/5hDz1vNRf43OunfcNeakNJ9L6+/BH+ZVE
85GfMb+0+46xH3mB/Vm/w/vQH95P7H+d5W78F/q2+B/W475Uvu3/SmV8meTG
l3Me+Ipo/jLat+K8/4hH0vg=
          "]]}, "Charting`Private`Tag#126"], 
       Annotation[{
         Hue[0.4145651649734816, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9gtUUVoEoAUEQLJSIKBEJ
WvgTQcnO5sHsNMvjzX7zZrfc7rc6JWNMxRiTn1Ipf362uGvrxi+nl2FeV+i6
rQT941FeF06cFt6ZU8U78d1piwuP/Fa8GFp4B84Ubw9f7u+QZ2j7t/Bl3ga6
Zvlr9Asvgi/3A+iq7V94/hz7Dqye8VfxjCnyTsWnj9JzKnhN4Xt+AN/lg25I
firy92Q/ejo9kf3RH8n7gO/ej7z3pUzxY/BX8j+4L/NO9ND/S6niXShRvATz
hHf18t+8fVPk/QN7J9Lw
          "]]}, "Charting`Private`Tag#127"], 
       Annotation[{
         Hue[0.6506331424732821, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9gtUWVkKUgCAIFooSzA9R
tPCvULJv82AzTfiYN9/OZsvtfqtTUkpVlFLZF3XTn58p3TWV6pfllZdVQq6b
ivXb8niUVagjy/Bd9NXxBfpu2ei8M+fhO9EP31F/Hd+BeczvmR+a/I6M87bM
14x/wz58PvuYX5KrJr8o9OfkgeFZYT+lcp6iLx+H55LPN+Ev9Jfs2/3IDewv
+f493E+elie4P/M+/g/99v+J+15H+Tr+E/1rvA/zOC+Qh/u+cnV8oUSOL+Y8
fAn3hS8t3PdG/gNsd9Lk
          "]]}, "Charting`Private`Tag#128"], 
       Annotation[{
         Hue[0.8867011199730541, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTsKwkAQhhdvYmknamE3d/AIgmLnVSxVLGw9gtUWVoEogiAIFoaIJCYk
ksJHLJTsbH6YTLN8zL/f7KPeH/cGNaVUQylVrFwP/fmZ0kNTiX5b3rpFxeC2
qQj5+ayoUN8tsy/QqfDddGbZ6NxrxeeD2efpXPgumMf7z8hPTf4E5nlH5FvG
f0CffXv0eb8Dbpr8ptJfgyeGV/orfEqVvOQ+5YLXVM7vsp8+ou+A7fnAHT4/
9o/4fvS0vOD7I7/n96HK+5H8Lw999vvw7/h/kOd5N8qEL6BU+EIKhS+q+GJ6
CV9C8j8euP8fYS/S2Q==
          "]]}, "Charting`Private`Tag#129"], 
       Annotation[{
         Hue[0.12276909747285458`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3S6walQRRAEwUFRiqWl
rQ5qdVB6OX/IZTk+knyXu1S7w06vopSqKaXKkyPXxdeE7ptI9cvyKigjATdN
xKifTsqIdGSZfVedCV+ob5aNLrg4vjOYfSf9Fr4j8tx/AI9N/R7M9+0wX8P4
t8izb+P0++C6qV86eQ++keGF/gifUv9555wnyR79fW32UyHyPtjOh/oWz09P
ywN+Hz0sz/j96N/w/zi+Izn/i/nYf0Z+zftBP98X0l3ulzLhiygSvtjxJc78
Kcl95OAfUa/SzQ==
          "]]}, "Charting`Private`Tag#130"], 
       Annotation[{
         Hue[0.35883707497265505`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkjEKwkAQRQdvYmknamE3d/AIgmLnVSxVLGw9gtUUVoEoAUEQLCKKGJSg
Fmq0ULKz+bA7TXj82bezuym3+61OiYgqRJR/tW6S/UxJ11Qqb8vLMK8ruG7q
Ah6P8koksay+s6SO7yR3y0YXHj3fwfPt5eP4YuS6ficvy0PTv0Wu+21wnprx
r5GrLwLr+gBcNf0LL5/DNzA8k6/jIyrmnWrOLs+58DXVz5mTB2A7H/obOj8X
5+3p+fhpeaLnR3+k9+P5YvbuF/Op/4B8pe8D1v1O/HDfl1PHl/DZ8V0839Wb
PwXb/w/9f0lP0sU=
          "]]}, "Charting`Private`Tag#131"], 
       Annotation[{
         Hue[0.5949050524724271, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwkAQRRdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLCKRkJAQ
goUaGyU7mw+z0yyfP/vm72x7PB9NWkqpjlKqPrlKXf1M6ampQr+tPgR15fpj
dd9UBr1e1ZXqxGrmJboQvFiXVhtc8HB4kcO766/ghfD5/g35lqb/Cp/nXaB7
hn9GP/NO8Pm+D901/XvH97CfhdE7J59Sjd6yT1J71PCGzKdK+D60zYf+Aeen
Jv+M30cvqzf8fvSfeD8OLyRnv8jH/Aj+kf8HmufF9JT/S4XgpZQIXoa8zMud
/AXJ/ygx7w89d9K+
          "]]}, "Charting`Private`Tag#132"], 
       Annotation[{
         Hue[0.8309730299722276, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KAkEMRgdvYmknamGXO3gEQbHzKpYqFrYewSqFlaAiCIJgoSiyoiyL
hX+NsvPNfpBNMzwyeUlmis1uo1VwzpWcc+mJSPTz86FtH7G+Ai8Xadz1Hbjq
40YeDtK4ahQYvkhj47toEtjrFuec78R+8B05D3wH5lG/12fgvr+/ow/9tuSK
929YD9+aedTPyWV/f5bLTzlPz/NEv8bnXMZj5MXyVLL+dfjlY/Jzedv5yDXM
z/oO9pNs/xH25/013kdy7ye592Ue/hPrV/gfMvpd5GH/V2Lju0pkfDf2g+/O
eeGLxf5Hwv3/Mh/StQ==
          "]]}, "Charting`Private`Tag#133"], 
       Annotation[{
         Hue[0.06704100747199959, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTuKAkEQhhtvYmgm6wZmdQePIChmXsVQxcDUI0xUgZGgIiwsCAYrig8c
hkHwmbhM/z0/1FTSfFTVV9Xd5Wa30So55yrOuexEpPr6+NC2j0QfgRfzLGJ9
Bq75uJCHgyzOegoM30kT4ztoGtjr5vuCb8d58G25D3x/zKN/o/fAfV+/pg/z
fslf3v/DfvhWzKN/xnzV10/JyEes73me6Nv4nMv3HSMvliPJfXX45WnyM3LY
j/yN/SW/bwf3I49wf9av8D5SeD8pvC/z8O/Yv8T/kDHvIFf7v5IY31mOxnfh
PPhiuRlfIvY/UvI/KL/Sqw==
          "]]}, "Charting`Private`Tag#134"], 
       Annotation[{
         Hue[0.30310898497180006`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbFqAkEQhhffxNJO1MJu3iGPICjp8iqWUSxs8whWU6QSNAhCIJAi4cKd
xx3nWWhMGuX23/th7m+Wn3/229mZ9ujpYdxyznWcc9UJlfp389KJV6G/wW83
lXL6vldGP59VSjUJHryDFoYX6zF4j9v86NXwogbvm/2A98Uc9z/1Evyzr/9g
jvfeye95/p45eDvmuL8mr+vrX1mPfMX6qfcv+m94ztX9LpGL9SupeUPw5Wry
NX3oj36A/qXu7xH/o1/g/6zfYT7SmJ805ssc/Ij5G/ZDHt6L5WT3K4XhpZIY
Xsb+wMvlbHiF2H2U9HcbF9Ki
          "]]}, "Charting`Private`Tag#135"], 
       Annotation[{
         Hue[0.5391769624716005, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FSoUhAEwUGpVEWp
OqjVRenl+kOa5fhI8uUuV273W52SMaZijMlOiTt/fja4ayPht+NFkMUVXLdx
AY9HWZz56Fh8J06UL+abY6sLDgVfVPDtOVW+Hb9U/xY8tPUb9Mu8Nbhm/Suw
+EKw9PvwVW39vJD3cJ+B5Rl/lc+YfH9TyZNmj3JfU/yUqrxP+r0h6htyf8rv
15P3gSfyftSHsh/Md/tDvdsv5ok/Qv9S/gd5mRfTQ/8vJcp3plj5Lpgnvis9
lS8h/R938B8Oh9KY
          "]]}, "Charting`Private`Tag#136"], 
       Annotation[{
         Hue[0.7752449399713726, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbFKxFAQRR/+iaWdqIXd/IOfICh2/sqWq1jY+gmpprAKRAkIgrDFStZg
2E02xeJubHbJ3JcLk2nC4c6ceS/v+Pr+6uYohHASQui/qFa7vZXeWjW6jfyW
9bXSv8jnVkvmjw99VVpGhu9Xa+crdR3ZdNmC8/AVI9+37pxvzv2Yn5Gn1v/F
eez7JJ+Z/4MMX07GfErfqfW/jvKE55kYv+i/84Uw5M/IpXOcyOC7hJ+MPBV/
35z5Bc4vw/nucD/yE+7P/hz/Z+Sbsz/+X+bwF5x/x/uQsa+U1r+v1M5XyY/z
LbkPvpVsnK8R/x4t+QAC39KN
          "]]}, "Charting`Private`Tag#137"], 
       Annotation[{
         Hue[0.011312917471173023`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTsKAjEQhgdvYmknamE3d/AIgmLnVSxVLGw9glUKK0FlQRAEi5VVUQzL
Fj4rZTPZHybThI/J/00e5Xa/1SkRUYWI8lUqM++fK9N1lYLXq7yseXmuu7qj
Px7ldTNnz+K7Gqt8F5N6drrVCXnxJYHvaD7KF2O+5A/godu/D86/A9ecfwsW
XxTkl+Cq278I+nPkB45n5qt8RMV5p9Lnr+I5F/mm+MHSX7K+b8TF/IacH9yT
+/HT80TuD18k7xP4YuT9+6Iv/gT5jfwPWOZdONP/y1b5bnxWvjvmic/yQ/lS
1v+Rgf/vINKB
          "]]}, "Charting`Private`Tag#138"], 
       Annotation[{
         Hue[0.2473808949709735, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb0KwkAMgINv4ugm6uCWd/ARBMXNV3FUcXD1ETrd4FRQKQiC4NBSWyw9
Sgf/Oim9XAO5LOUjuS9J0x7PR5MWAHQAoP5SlOrzM6GmJgrm46EOrd6W+yZy
5vWqjkwllsn3UFr4UlVYNrrD3fHF3I98kfoKX8j19P7GvDT1V2f+C3PP+M9c
T77Aee8zd0393sl77FsY3qlK+ACaebeUx0qwh837IfmZKe+j3DfApv+A5mee
0X74sryh/dkX0P9xfCHKe0WcJ3/M+RPdh33UL8VS3he18GWYCF/u+DQ+ha9A
eY+S+/0B6GjSfA==
          "]]}, "Charting`Private`Tag#139"], 
       Annotation[{
         Hue[0.4834488724707455, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9QqotrAJRBEEQLAyJwZAQ
UvhbKdnZfDA7zfKY3TczO83hdDBqKKVaSqnq5Cj1+2dCj00U+mV5F1SRg7sm
MvByUUWqb5bZd9eZ8CW6sGx0Qez4ItRnX6g/wnfFfX5/Ac/N/TOY653g6xj/
EXn2HZz3Prht7m+dvAffzPBGf4VPqbrfNedJskf1+z77wZz3wbY/quv3uH/w
hOejp+UVz4/8gf+HnP8jua8QefZH8O15P+iH6yVUyv1SJnwpxcKXOb6cHsJX
kNxHifn/3YjScg==
          "]]}, "Charting`Private`Tag#140"], 
       Annotation[{
         Hue[0.719516849970546, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQRhdvYmknamE3d/AIgmLnVSxVLGw9gtUWVoJKQBAEi4hB1ERJ
4V+nZL/kg9lplsfMvpnZLbf7rU7JGFMxxmQnIrWfnwvbdfGwr5zXqywS+865
7iImj0dZXG2UM3wXe1O+s73n7HSryPOdPN+R88AXMo/7B843dPV75tFvR645
/5YMX0DG/SW56uoXXn7OeQaOZ/arfMYUPEVeNM+luN+En4z8UvS+gRT9G5hf
in172I88wf6sD/A+oucLxXtf9oP/RN8G/8M8+p0l1f8rN+W7SqR8sedL5Kl8
D9H/kZL/yaDSZQ==
          "]]}, "Charting`Private`Tag#141"], 
       Annotation[{
         Hue[0.955584827470318, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FRQKQiC4FBpKR4t
tYNaN6WXu0Auy/HzJ1+SS3s8H01aSqmOUqp5KSr8/Ezg1ESJb6uPhyYK1n0T
OeevV01oTK0m3gO14GVYWG1wh5TriZd4vDvWghezT/U3fFm9NPlXb/4L657h
n3l+4kXsU33Iumvy954f8DwLo3f4FTylnN6SD7XQAesh8T0/BLlvBK7/gOYH
N/+M9gO3/4b25/yI/sfjxeD9L/vET5h/ovtwPvXL4CnvC1rwNKSCl3u8gucl
XgnyHhX3+wO4uNJY
          "]]}, "Charting`Private`Tag#142"], 
       Annotation[{
         Hue[0.1916528049701185, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbFKA0EQhhffxNJOooXdvIOPEEhI56tYarCw9RGumsIqkIRAQAikUO44
stwRA+rFLuH23/1hdprjY2a+m5m9HD7cjy6cc1fOuf6LOGh3CqHjEHv9i7yY
99GSb0I0rJ8+9+G1igzfTr3x1dpGDrp5xX74ysz3pUfj+2Qe/Vv9jfwU6jfZ
/B/kQfCvOT98KzL6Z6y/DvXvZOQLzvMY+E3/jc+5xK/IS2e4kNR/Bz8Z+Rnr
43yS5rvF/OQJ9pO0/wv2Z36F+0h2P8nuyzz8JfuXeB/W43+1fNv3FW98Xirj
azJfKz/Gtxf7Hgfufway+NJS
          "]]}, "Charting`Private`Tag#143"], 
       Annotation[{
         Hue[0.42772078246991896`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KAjEQRoM3sbQTtbCbO3gEQbHzKpYqFrYewWoKK0FFEATBQtlFXFxU
8LdTNl/2g2Sa8JjJy8yk2Ow2WgVjTMkYk52Iu75/NrRt46ovx8tFFim5auPC
+uEgi0Rjx/CdNfF8J00dW90iDnxR4Dvqx/MdmMf9vT4d9239jj68t2V9xfo3
zMO3JuP+nFy29TPeR35K7lme6NfzGZPzGHl5ezwl1+EP8nOy60/yfmroX/J5
O5hPHo5HmJ/1a+xHgv1JsF/m4Y/oX+F/WI/3TnLz/1cSz5dI7Pku7Ae+lP3C
dxX/P+6c/w+noNJJ
          "]]}, "Charting`Private`Tag#144"], 
       Annotation[{
         Hue[0.663788759969691, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbFKxEAQhhffxPI6OS3s5h18BOEOO1/FUg8LWx8h1RRXHeQkIAiChZIj
JCTEgHpep2T+zQ+z04SPmfny7+7x5fXF4iiEMAshjF/UoD9/Vrq06vU78jYf
qyOfWrWcX92N1eguMny11s5XaRfZdPmO+/CVune+D/11vnf2sf/GPLc2/5rk
f+H83PzP7MNXkLG/IZ/Y/Jr76GfkG+NHPThfCFPeB/Rl7zgjn8Of9DfkmE+m
PGfIL9N5r3A++Yp8j/NzvsD9SHJ/ktwv+/CX9D/hfTiP/1Xy6d9XaudrpHS+
NvF1zAtfL/49BvI/mYDSPw==
          "]]}, "Charting`Private`Tag#145"], 
       Annotation[{
         Hue[0.8998567374694915, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkT0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9gtUUVoKKIAiChRLxh0gQ
/CuV7Ns8mEwTPmb22zfZYrPbaBWccyXnXPpFPfT986VtX4k+Ay8Xad31Fbjq
K+b8cJDWTaPA8F31YnxnjQN73eLE8/BFOd9RP8Z3IOP8nvn6fn6Xy7/lfMX7
N8wP35rzOD8nl/38LNefknueJ/o1Puey+8boi+UpuQ6/vE1/Tg75yDXklyx/
B/tJtv8I+7O/xv8Rm+/A+8P/JcMf8fwK78M+7jtLYt9XLsZ3k8j4YuaD706G
LxH7Hg/u/wd+0NIr
          "]]}, "Charting`Private`Tag#146"], 
       Annotation[{
         Hue[0.1359247149692635, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkbEKwkAMhg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FRQEQRBcFAqam0p
glZHpZfrD7ksx0eSL7m7anfY6VWMMTVjTHFKPDn/2eC+jYxfjterIlJw00bC
b8fTSRExR47Fd+eb8l354djqVhf0iy/yfGf+KN8J+0n/EfuMbf3B23+P/ob1
7+AX3xYs/SG4buuXXj4Ajywv+Kt8xpTz5pInzQG4LX7KVT4Eu/2onNeS/am8
70DuB57J/VG/lfch7/3gd++LvPgj+DbyP6iXeVfK9P/STfliOilf4vlSb/+M
9H88wX9mwNIX
          "]]}, "Charting`Private`Tag#147"], 
       Annotation[{
         Hue[0.37199269246906397`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkj0KwkAQRhdvYmknamG3d/AIgmLnVSxVLGw9QqoprAIqgiAIghGDGBKC
+Fsq2W/3g8004TEzb2Z3U+0OO72KUqqmlCq+iLu8fiakbyKXp+X1qoiM3DSR
sn46KSKRyDJ8N4k931USy0a3itkP36XkO8vH80Xy9vqP8rA8NvUH5jFvz/6G
8e/oh29LRn9Irpv6ZSkfkEeGF/L1fEq5eXPktc+Bdvu14ScjH5LtftrNa2F/
7e5/gPNpd/4Zzs/6Le6n5IvI9n65H/wX+jd4H9Zj3lXn/vvq2PMl+uT50pIv
477w5czb/4/8B05o0gQ=
          "]]}, "Charting`Private`Tag#148"], 
       Annotation[{
         Hue[0.6080606699688644, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdksEKQVEQhk/exNJOWNidd/AIiuy8iiWysPUIVrOwuoWUUopcHYnoJlyW
dGfO/WvObG5//5xv/jnnFpvdRqtgjCkZY7Kv1IPePy5qcyX09Hoxz+pOL6+r
XDf0DwdZXengtfAu5BTvTBevGTc/BTwX8I70UbyYUnV+h3x97t8G+Tc4X2H+
Gr7wVtByPkKeMvfPAn8Kv8d6Ql/FMyafNxbfaj21Oa8ufGjxI5vqfPBrkt/m
8zuyn833H8n+6F/J/QS8GNrfL/IJ34G/lPcBT+adbaLf1zrFu9q94t0C3h15
hZfA9/8f9B862NH2
          "]]}, "Charting`Private`Tag#149"], 
       Annotation[{
         Hue[0.8441286474686365, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb8KwkAMxg/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FSoIgiC1KFyUlpa
Sv1TV6WXayCX5fhI7pcvSXs8H01aSqmOUqp+KUr8/Ezg1ESBL6sPQR05vq3u
m8i4fr2qI8XQauIlqAUvxsRqgwseDk87vDt+BS/CSvy/4dPqpam/Mo/6Xbi+
Z/hnzhPvxJr++8zrmvq9k/d4Hwujd44/pRq9pTxI7UEz35D4rCnvQyX9QdN/
QP6h6T+j+VhvaH6uP9F+HF7E2u6X/RFf8/8j3Yf9Ub8YCnlf0IKXQih4Gfsj
Xu74L0Deo2T9Bx5o0eI=
          "]]}, "Charting`Private`Tag#150"], 
       Annotation[{
         Hue[0.08019662496843694, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkj0KwkAQhRdvYmknamE3d/AIgmLnVSxVLGw9QqoprAQVQRAkFoaIP6hB
40+rZGfzYHaa8Hiz37zZTbHZbbQKxpiSMSb7Sj349bPFbVsJp04v5lndoKu2
rugfDrK6cOi08M4cK96RT05b3Pzg8WJ+K17EH8XbY56c3/HT6b7t33r5N+BV
LH8NX3grzJfzM/DKtn/q+QF0z+qJl8+Yr9Nj8emjdEB5nrrwKVX+DL7LB78m
+aE7sh/0SPanfL+V3A9590f6vSL4wo8p338p74M8Mu9Id/2+FCvehULFuyKf
8G5e/gTa/X/Qf/4B0ck=
          "]]}, "Charting`Private`Tag#151"], 
       Annotation[{
         Hue[0.3162646024682374, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkTEKwlAMQD/exNFN1MEtd/AIguLmVRxVHFw9glMGJ0FFEASLg/KlWluk
auuq9CcG8rOUR5LX5Kfc7rc6JWNMxRhTfClSfH9dYNfFA1/M61URiXDdRSz1
41EREQbM5LuhVb4Qr8xOt7p4Puv5zpgr30nqqf+IT+ahqz948+8xY645/076
ybcVpv4lpsxVV7/w8nPhgeOZN58xH+Yp5SFTPBdukh9eKr+UPM8n+QbNL9yj
/eC//4T2h//+W3ofz3eSfn5fyJXfim9D9xEf/S+Eu74vWOWLIFC+2PMl3vwP
0PdIhX/u+dG6
          "]]}, "Charting`Private`Tag#152"], 
       Annotation[{
         Hue[0.5523325799680094, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkb0KwkAMgA/fxNFN1MEt7+AjCIqbr+Ko4uDqI3TK4FSoIgiCxaFSqUpL
rf2ZlV6ugVyW4yO5L7lLezwfTVpKqY5Sqj4pMsx/OnCqI8Wv4YNXR8L5vo4Y
C8PrVR1v9A2T74WB8EX4NKx13sPyhczku2MlfAHn6f6N51vq+isz9btgabin
/WfMhO9k3Xc539X1e+5HeYd5oXlnzadUw1vKQyHYYR6SH3KRd6GU80Ez34Dm
Z57R+5g39H72n+h/LF8A1v9CJfwh+460H/ZRvwhecr8QCN8bfOGLLV8CH+FL
Qe4j4/o/0MHRnw==
          "]]}, "Charting`Private`Tag#153"], 
       Annotation[{
         Hue[0.7884005574678099, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdksFKw0AQhhffpEdvYnvobd7BRxAs3nyVHm3x4NVH6GkOngKpBAQhICQS
Gw0pNTHtWcn+mx8mcwkfM/PtzG4m13dXN2fOuXPnXP9FNNr++dCFjwN5G/ex
J0991PobeL3qo9I0MHzfmhlfqbvAXhd/jnzFyPehnfHlzKP/nf33vj7Vxpz3
xvpL739lHr6EjP6IfOHrn9mP/Ia89PykR+Nz7hT4EXnpDG9k6J/DL63JR2L3
TWSYZ4b5ybfYj/0P2J/9Ce5H7Hy5jO6X9fAX8hP4Be/DPM4r5cu+r2TGV0lq
fDXnhW9PP3wHcvj/WP8PqbHRgQ==
          "]]}, "Charting`Private`Tag#154"], 
       Annotation[{
         Hue[0.024468534967581945`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkj2KAkEQhRtvYriZqIFZ3cEjCIqZVzHUZYNNPYJRBUaCysCAsLCIMoO7
osz4lyvTr+dBTSXDo15/9ap76r1Rt19zzn0454ov6qrXly8d+Mr0FvR6VdRF
86Bbvs56D/pzWtRJ46DB+9ed4R01DdrjVin54CXkg3cgH7w9/Tj/y7wT7/+p
5N/S3/T8mH3wosr5JXXD+xc8j/6ceuz1TJ+G51ypv9GXh9FzKffpgC+56S/F
7htJmaeN/NRD7Cdlni/sz3kR7qfC29Mf7pd98BPm2eB96Me8o/zZ95Wd4Z0k
Nrwz84J3kczwMs4L/x/9b3WR0Vs=
          "]]}, "Charting`Private`Tag#155"], 
       Annotation[{
         Hue[0.2605365124673824, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkr1KxFAQhS++ieV2y2phN++wjyAodr6KpYqFrY+w1RRbBbIhIAiigUiW
YMiaxPgAK7lncuDeacLhzHzzc3N6ebu+OnHOLZxz0xcx6HD0odc+Ov01vUun
OGhv+sxHq6Ppx4cpGs1Mg/etRcCrtTLtcek+4lX6E/C+2B+8khr1n5z33ue/
R/O/MX/l+a/0wcvZH/UJ/aXP30b8DfWd1y/cf77gn+ln+DIGeiNz/QX40gd+
IiEvp3+O+Vl/g/2on7C/zPvmuE/EK+nbfanBr6QzneF96KNfLR/h+0oR8BrJ
Al7L+cA7kA9ex/3s/2P+P0R50S4=
          "]]}, "Charting`Private`Tag#156"], 
       Annotation[{
         Hue[0.49660448996718287`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkjEKwlAMhh/exNFN1MEtd/AIguLmVRxVHFw9QqcMToUqhYIgWGipFEtr
bb2A0pf3AnlZyk+S709e2p+vZ4ueUmqglOq+FA1+fjpwqaPGxuhL0EXF+bGO
Eluj97suCgyMJt4LY8HLMTFa44In1oKX4VvwUvYjXsJ+1P/g/q2uvzvz37h+
pPmRwwuxEv0+54e6/uzkPfbbaH3iee0Lfo0+Uh6k9sDyp8RnTXkfWjkfWP8J
zQ/Wb0X7gb3PgfZnHdL7OLwE5L1S9id+Bna/K92H68kvh0jeF2LBKyAQvJL5
xKuc+Wv2M/8fz/8H/xrQ9g==
          "]]}, "Charting`Private`Tag#157"], 
       Annotation[{
         Hue[0.7326724674669549, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxdkjEKwkAQRRdvYmknamE3d/AIgmLnVSxVLGw9gtUUVkIUQRCEgJFoSMga
gxdQsrP5ME6zfP7Mm5ndbQ6ng1HDGNMyxlSnRMnvrwseuyigD0EVllOvuy5y
+MtFFRkHXgsv5VDxEr557XDBg63ixdDCu3OheBGXqj7kl9dzl39FvvS7IL/j
+GfMK7wT+kn9HvVtl7/DvuJvOfN65vSGc8Uzpq5fi08fpbdU+33hk1X+nko9
H/yezA89kf2o3n8l+6P+JPdDet8Ivr9fzCP8mOp9jvI+8KVfQkf9vhQqXkaB
4uX0VDz7N3+B+f3/Q78fqZLQqw==
          "]]}, "Charting`Private`Tag#158"], 
       Annotation[{
         Hue[0.9687404449667554, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kksohFEUx2+mxEoWHgsbG6FIKFPkKEWyQikL0sgMCY1EeSxGkkGTx8Jz
xI7IgoUsdDCjjAaDPJPXaGZkmmajvjEfae499yy+r9u593fO+f9Pqq6zujmK
MZbBGIv8RQQxo2jnajmoop5HAOMqwjWtPhXPnJHwo8vb/v13oWIejy+s3Dae
sDUVF+Yj8YnW0g5Nr1FFwfPhVULb4WmW5HnQbt3o2n8OI8c5P7Bn9yCzYSRM
PDf2jd3/qmlh4r2hb9FkTbH9EO8VowoNdbr6H3r/hKbsbsuwEsI5fv8B4xPd
jQWzIap3i8fj5tqkohDmcv41Gi7fNVOfCvFceFS8MGFfVei9A0tivX1NegVz
+H0bbs1U9YxqZX4PLwdezJZkBSf5eR0fB6c9mmjJYyyGfxVcEXm4o7w478EN
vdcKPmwSX+QdUE71qT+Q/eWL/qGV+m8R84Gd5lsS80Mqze8S+sAQ6UP6gdSP
9AWpr+C7oZ/0Pxf+QBf5I+p5wE/+kb8g/SX/QfoveF9QRvsheH44p/0RvADE
037R/kE67d8/voNa7w==
          "]]}, "Charting`Private`Tag#159"], 
       Annotation[{
         Hue[0.20480842246655584`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk0oRFEUx28mShazGixslIgioUg4SilLlLIg+ZZ8jGRKlCnJoMnHAsOI
HSkLimahYxrJyMdDiZKvpzGTaZqUeuM90rx77lm81+3c+zvn/P8ntbmvpi2G
MZbJGIv+eYQxo2TvZi2sYbseIUyoUmu7/BpenEcjiNJHz/fflYb5enxi+a75
lG1q6FiORgC7KnoNFrOGnOdHNHW7z7IFz4c7zu2BwycVddz5O5oPjrIaJ1Ti
yTg8df+rpavEe0V5xepM8fwQ7wW/ijvqmxt+6P0jjuUM2seVCC7p9x/QmCg3
FS5GqN4duqdtdUklEczT+bfYev1mmAsoxJNwv8wxc7yh0HsvlsZ/DLe0K5ir
3/fg9kL10GSRyLtQGnm22ZMVnNXPW3g/Ou8zxAkeY7H6V8F1ngeJ8vzsgkt6
X8T5IPg874Uyqk/9geivgPcPbdR/J58PxHyrfH4w0fwS1wespA/pB0I/0heE
vpwvg4X0v+T+QD/5w+v54IT8I39B+Ev+g/Cf8z6hkvaD84JwQfvDeSEw0n7R
/kEa7d8/fnxbfA==
          "]]}, "Charting`Private`Tag#160"], 
       Annotation[{
         Hue[0.4408763999663279, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl8oQ3EUx68ppTzwoCiFl9XetInFw3mhPGrZi6JMQ1KeKKI888DTsqUh
UasZWa1WcpQ/tYytzI1aoa1rs2u/bWwjHrT7O7/zcG+/zu/3Oed8v6fdNmux
6yRJMkiSVPnzyOG4MT4SUxhOaJHFvH1e/lMY3oYroeJJXQDm3hiatMhgccXt
7kkxdDkrkUaffN0wkGbIeSn01a8VHO+Cp+CBYbK6VWWo4cJJ7B6r8cofgpfA
pUtrv58J3is2Jc3LnrzgveBesy5z+Cnex/G4pc0UKDLc1O4/oWE4vnpaFvVk
vNk6U2M/DI0a/x7Pner2oJQjXhRrY4/WYDJH70P40KhEjUcF7NDuX2Bi3b9w
5f2ifBB7I78zhukSbmhnD1r0+65RRxmFglXa9xt3eB6GKM/PQeij92bOh2fi
83wIIlSf+gPRXyfvH0T/U3w+CNN8W3x+0NP8Ua4PCH1IPxD6kb4g9OX8BCyS
/nfcH+gif3g9BXbJP/IXhL/kPwj/OS8DJdoPzlNB7A/nZaFA+0X7Bzbav3+o
cmab
          "]]}, "Charting`Private`Tag#161"], 
       Annotation[{
         Hue[0.6769443774661283, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8ow2EYx3+YUlyI4qC4YGnRKIp6chMH/1IOOJClmUg5uLnOxXIQQ7nI
31AOGsv3ILQMKzYUi5kh2k9oKxba733e5/L29rzv53me7/fJ7xpo7klUFEWv
KEr8FPGOCVt1SveMCpMWYfQ11h7pZlWcuOPxhlTrWFJoTkWZFq8IeDK83/Mq
7NPxeMFQm9NZsqBC8J4xmr5aZF6RvBAMhc0G66YKDecOIie3eNi0LXkPCLY3
DV7uSd49KiwdgfVDybtDZl2/Eafy/w0MeTuffp+KKe39NXSNgZOIX9bz4bbP
HGt5UmHU+OdwdiwtpsUkz4Pki6tWR/Cd/7twkRXyGDc+UKq934d3fGvkYO2L
8w5Unf1Y9OYIbNp9GQ0FC/bOySikgr9/8YhiXuSpnvPi7qAa/l8p+ORnvsi7
6Jjrc38k+ysX/dMu998r5iM536yYnxJ4fo/Qh4pZH9aPpH6sL0l9Bf+BHln/
U+EPZbM/ol6ICtg/9pekv+w/Sf8F75XkfgjeG8n9EbwwWXi/eP/Ixvv3D1xk
X04=
          "]]}, "Charting`Private`Tag#162"], 
       Annotation[{
         Hue[0.9130123549659004, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8oxFEQx19uLi7O2/pTysrfXaEwtFxoS5I/tSciDkhJKCl/ThzsQaFd
KRwcRGkPq9UcXGzY1pKNVv6LrH0uDhKr/c3MXF6vee8zM9/vZHYONnenKKVy
lVLJk+IT61r0761JY48RcRxpmuprNGs8PUlGDB9q8ndmsjVajXjH8MFm+pBF
48pyMt7w+mMs9GTVSLxXLPBbqjZAeC+YEk4b6HZoNHAnT3iojx1hp/AeMaP0
u36uX3j3WJ3j3bdMCu8O57q8ZQ0u+R/FjgvT/Py6xiXj/RXa9oan/F6pd4mz
8cXExJHGEoN/jtHxkurpmPBCmNdenBX5kf8BrPXsmod+NRYZ7w/R0+Jqc/1J
3oeF2yroTGhcMO5b6KmsMEcSwlMqlXVcozyscp7uPsjn/+XEBzfzKR8AO9fn
/kD6s1H/cMP999J8MM3zuWl+kPlDpA+0sj6sH4h+rC+IvsR/BNE/SP6A+EP1
XuDrjPxjf0H8Zf9B/CfeO4R4P4gXg2feH+LFYZT3i/cP7Lx//7hVVfU=
          "]]}, "Charting`Private`Tag#163"], 
       Annotation[{
         Hue[0.14908033246570085`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8oxFEQxx8lcdmTw1I2fy5ayb+DkoaNopTCjYO2yEHLtheFQpSUcrEh
IiK0KXGwB035c1CWjRBJtBJ2e2+zyd9F+5t5c3m95r3PzHy/k2HvrG+NF0Lk
CCFiJ0UYuz76PXMOiW1GSPQ7TcPZTom+o1iE0HbgsSx2SywyIojuc6s5NCRx
eioWz7i1Xn65MSGReE/oG2pxj65p3iPO7CdWR3YlGrijB6zIPKlpuNW8AObV
DZjjfjTvHjdtjX3VaYp5d/ht9S25ShX/v8Ede+7LTZPCSeP9FQbGW1+zehXX
u8DUSHpx46zCQoN/hktuy8r2qeb5Mbkg+GtX+v8hit2U64M3hfnG+z38rF2I
Vn3pvBfDqqPHFVU4btxX0WkaHGv+0zwhkljHecqDg/N094Lk/yXEh3fmU/4Q
Erg+9we6v2LqH5a5/3aaD/R8MzQ/6Pn9pA94WR/WD7R+rC9ofYkfgFzW/5j8
gTL2h+o9wgj7x/6C9pf9B+0/8YKg94N4Iajk/SGehBPeL94/cPL+/QMKZVvK

          "]]}, "Charting`Private`Tag#164"], 
       Annotation[{
         Hue[0.3851483099655013, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kjtIglEUx68uRRD0WCOxra2HUvQ6PVzKLWipqUiLIFqyoddcDSpBVFai
RUMFPZbA6QxNhpppiVZQYYnx9X1f5FAkVPjdc89yuZx7f+ec//8YR6b6bXrG
WC1jrHDy+MCb2OBHpVNGuxYKti52VelWZQyHCvGOvam96MmOjI1aSOg1DlgS
pzJ6Ngvxhq5YtT9/KSPnZfGzxWSekwQvg8nZsexSuYIaLvSC9lRO19SmEC+N
e0vLMwsTCvGe0Tl95ujZUoj3hI5688pkWPx/wLJIX/z7T8EN7X0Kb3WPNdYG
leol0O9+NSdtKjZo/Dh2unSxo2OVeFHMG9cN53cq/Q9isTTUrn9TsU57f4He
tfsrQ07kA1gijcYsPyq6tfsBWr4O592/gsdYEeno43nopjy/B0D8b+Z88BCf
54NQSvWpPxD9mXj/IPof5/OBj+bb5vNDnOaPcn2ggvQh/UDoR/qC0Jfz07BP
+ke4PzBM/vB6Gbgm/8hfEP6S/yD85zwJdmk/OO8drLQ/nKdAB+0X7R+I/fsH
BkhbDg==
          "]]}, "Charting`Private`Tag#165"], 
       Annotation[{
         Hue[0.6212162874652734, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kj1IQlEUxx9CtTQVQmMWgUVDaEMtHmwpKAiEhIaWRBEyIgqJklBJCFpe
RFDRENjS0hA0GMShclAwkT4NtBTFNN9HSxhRGL577lkul3Pv75zz/x/D7ILN
qRMEoVcQhMbJ4hPfMsm1mE9ClxYKLkdXsnNBCW8TjZCwGNLPm3YkNGtRRd/F
uv3sVMKD/UZU0N8ZGLM8SMh4Zazpx1s+dDLxSuiJNSXFYRk1XKKIIz2e7axX
Jl4Bj7+vF6ciMvHy6MgWZpx1mXg5tFqiRu+oQv8zKDr70m2ignva+xcMZbau
7GmF6j1hfvexo7VLRZPGv8fEtNnv9qvES2HCWCtKlyr9j2Po3FXvf1ZxQHt/
g7aJctlQ4fkI/rY7uu++VBS1+wkGJ8Ow9Md5gtBMOh6xPAQoz+4R+KH/Q4wP
nM/ycdik+tQf8P4GWf/A+3ez+eCV5jtk88MGzZ9i+gDXh/QDrh/pC1xfxi9A
mPRPMn/ASv6weiVwkn/kL3B/yX/g/jNeFVZpPxhPgnfaH8ZTgO8X7R/kaP/+
AWM7XBE=
          "]]}, "Charting`Private`Tag#166"], 
       Annotation[{
         Hue[0.8572842649650738, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8ow2EYx3+0TckOO8gcHDgQSRoHtfKsKDYHciCXTcM4CDm4kouU5LY/
aSmlllIoWg7Pag1jm0lWahZtren97ffDWUv7vc/7XN7envf9PM/z/T6t7tXJ
hVpJkjolSaqePL5xvm7X5LIy9Gih4EM0sqgfYphMVENGL9ZY7mcY9mnB0OFb
N5g3GQb81fjC7Y0rXf0FQ84rYXJsTu/8EbwiNtnc1h2rjBouUcDGV4fzel8m
Xh5vzrpjckkm3icOhisx3WiZeB/o6rAHM6Ey/c9igRmbPQ0K+rT3b6g+brG1
FYXqZdA4exr7fVbQovFfMNdzxyojKvHSaN6znXT5Vfofx/NM2/J4RMVe7X0U
A46p4ERW5MN4mzsebvlW8UC7hzDVPu3Q/wmeJBlIxyOehyfK83sYYvR/gPPB
S3yej8Ml1af+QPTXz/uHd+p/ic8HYr5DPj8oNH+a6wN50of0A6Ef6QtCX87P
Q4T0T3F/wET+8HpFMJF/5C8If8l/EP5zHgM77QfnyeCn/eE8BVK0X7R/4Kb9
+wfML0/Q
          "]]}, "Charting`Private`Tag#167"], 
       Annotation[{
         Hue[0.09335224246484586, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk0oRFEUx2+Tj70a02TEkGKHUVjoFAsbKXbKQmo0U2Kht9CEqbFTPjbT
kGJBUhYk+Vg4SWg0o4mhZMQgee/NzENKpEbzzrlnc7ude3/nnP//OPuHu90W
IUSNECJ3Urzjg7FqTJ2rOGBGBh0j3kN/XMVoJBcpVJYqfeWfKrrM0LE+frKz
WaHhwnwuVHzy+q3CrSHx3rDIl9c3tKsx7xWdycKNb5uOJi7yggfBqrvWSZ15
z1gcOk1s/+jMS+J1tsQdUFLMe8S2rNeT/Erx/wTarZeZBiWNIfP9Lbbc2/Wz
rzTXu8FSu2VlVslgvcm/wpnpxuZAvsG8GDZ3ax/BQYP/hzF65OtUVgysNd8f
Y7ZjbWwrIvP72FPWNVetGjhr3tdxwj9R1/4reUIUsI7LlIdxztN9H3r5fxPx
4Y/5lA9DjOtzfyD7a6D+YZr799B8IOdbpPlBzh8jfcDG+rB+IPVjfUHqS/xn
cLD+F+QP7LE/VO8VpH/sL0h/2X+Q/hNPBxfvB/FSMMr7Q7wMyP3i/YNb3r9/
mYdXmA==
          "]]}, "Charting`Private`Tag#168"], 
       Annotation[{
         Hue[0.3294202199646463, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kj9IQlEUxh8NDZJLf6gxqaCIIErJWs6kRDUVUZBQRIYh9HLJEJpCKCJq
y8TB1agIcrGhAzWUZilEhdSgaPaePn0OIbVU+O65Z7lczr2/c873HcOiOGmv
EwShRxCE2smighe/h6eNvRIua1FGd6y9Lzgk4UO8FgpuWl2RH5uEg1oUccEw
5jX6JfQf1UJGt+njL1GSkPEkDDd7SzgtEy+PSkj0eBIyarh4DjOdYYdutkC8
LILN8tWlFIiXwbdPvTixXSReGjtm4nKlW6H/7/iqC+/fxhT0ae9T6Bxx6/ec
Jar3gndT1h2loYwDGv8JW++rK/pImXhJnN9tWpszq/Q/imempeeTLRX7tfc3
uHoVGB2/5PkI+q9dUjWt4oF2D2GuxX48/K0iV7CedAyyPGQoz+4R8NF/M+OD
SHyWj8I51af+gPdnZP1DG/XvYPMBny/A5gc+f5LpAynSh/QDrh/pC1xfxs+C
hfR/ZP4A94fVy0Oe/CN/gftL/gP3n/GKwPeD8RTYoP1hvDKs037R/gHfv38Y
cFfr
          "]]}, "Charting`Private`Tag#169"], 
       Annotation[{
         Hue[0.5654881974644468, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kj1IQlEUxx8OEoHQ0lpENDRVfkCLnSFqiFra+0DIQogGo9khGkpIiMBK
IqQic6iEKKcjSJigIUlGaFQY14/3fE/ICKMhfPfcs1wu597fOef/Pz2OlekF
gyRJ/ZIktU4edYxbu6/iMwydeqiYD17HzMsM06lWKFjxDPx0HTC06CHjuRSX
FxnD/b1WVNA14B6xTZWQ88p4OtT7a0iXiMewjNaniKOMOi71iTtN5g62V4hX
xMDYxVwiViHeBx6HRo1ZT5V477huy0vOcZn+F3CiYbl3mRT06+9f8LbNdPn1
qFC9HJabZ9kOfw3NOj+LdpdxPupQiZfBzruaN/in0v8kbhdW14yzGg7q7+OY
bSTrfSca5aO4ET4Mbz1r6NPvIbRHdjdfvzUUChpJxyOeB5Hn9yiI/8OcDzni
83wSfFSf+gPRn5X3D6L/JT4fMJovwOeHG5o/w/WBSdKH9AOhH+kLQl/OL4Kf
9H/g/oCX/OH1GLyRf+QvCH/JfxD+c54MIdoPzlOgSvvDeSoUaL9o/yBB+/cP
3RJdMg==
          "]]}, "Charting`Private`Tag#170"], 
       Annotation[{
         Hue[0.8015561749642188, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx99WZsQFLSIr4kZuZJKbOTcuWObCHTcrIlcoJVaS5EJhI8nH
Jm42lHI7H/2LpNV8NKWEGvvANhtJudTec95z8/R0nud3zvn/T1XvcFe/TlGU
WkVRsifHF5yFvlZHXxQDaqSR7Ki0F49FcRXMRgrrOfrf/oMozGokcTYx+1hm
iGFjPRsfMEwWj/7OxMC8d3RuBea+TXHhxfFnmTbaQnGouGAUdmP3q8/9JrwI
Bk0jRTXj78J7Qbcn79ll/xBeGNamzQuvLSH/n7B5qAsPWZJYU98/oD2Bnfq6
lNS7x35JtbOg9BMNKv8O+YsjEa8uLbxbTE85Qqv+tPwP4CjkvFkxZ1Cvvj/H
YqNj2bqQkbwfx/uTp4lgBi71vody6/yl+ScDTUG96LjNeaqQPN/9dCr/m5lP
88LnfIBOpL70R1p/jdw/5Ur/gzwf7cp8bp6f2mT+W9aHPKKP6EeafqIvafoy
P0Ka/tfsD/WIP1wvTkoL+yf+kuav+E+a/8xLEmQ/mJcij+wP89IUk/2S/aMl
2b9/I49Ksw==
          "]]}, "Charting`Private`Tag#171"], 
       Annotation[{
         Hue[0.03762415246401929, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx1+fk5oL7YJEWU2WlNiFmzlXvlJiKy6UtPJVsogVLshHzZ18
1CzJjQu1XXChVtohUqv5SmRSY2M2m70uFC5Ie895zs3T03me3znn/z+lFqup
N12SJL0kSamT4gM1+r2GImMI+5RIYqXry6Y1h/DMn4oEHhjcAfdqCGuUiOOu
IziqlcLoXE9FDIOnusLgchiJF8XuuXl1a/Mz8yKomtGM/5a8oILzP6P63nPj
zYswL4ztF5OD5/mvzHvCtk67JksXZd4jLoz8TRdDjP8/YH99xWFZ1xs6lPcB
3DCXxybG4lzvFjvr9mc/FxNYrfCvsXFzYvvH8c68S7xLBLwWa5L/+3Cl58Q+
lCljlfL+GHOvvoePR2XOezDHlTFTcCTjknLfwanPFpvxQ0ahYDbruEV5EHm6
e0DF/2uJD4JPeR+scX3uD0R/Buofmrj/AZoPOni+DZofnDz/JekDVtaH9QOh
H+sLQl/ih8HE+p+TP5DG/lC9COSyf+wvCH/ZfxD+Ey8Obt4P4iXAy/tDvCSI
/eL9g3zev38IzUwH
          "]]}, "Charting`Private`Tag#172"], 
       Annotation[{
         Hue[0.27369212996381975`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx99WVsKdMilyobhbZk1cHLcUQhrFyuQjJfckSna12lbKZ1lx
s1I+byacC4nJx5CxEu/sNWafCheUtPec59w8PZ3n+Z1z/v9Tah1p7dNIklQh
SVLmpEhj3a68X373hP1qJLG7a9zQnCXj+Vkm4lhilHofW2Q0qBFDx4un3Hop
48J8JqJotx2snYyGkHhviA7L9HPzM/MiqMsPGSfqw6jizhScmZo6dvUozAuj
3a1ps7hemBfC4eXc3u2rCPNkvB3NU0xFb/z/Acd1HUOv/VGcU98H8W8v71O7
/s71Anh/tJGjpGNYqfJv8MucXRcsSzDPjwWBFUVfnOT/PtycHDCt+pOoV98f
oremIbLYnuK8F5s6J64Ld1LoVO8e/PpInP7GUygU1LKObsrDN+fp7oVG/l9N
fBB8yvtgi+tzfyD6q6L+QfQ/SPNBkOdbovnhh+f3kz4wxvqwfiD0Y31B6Ev8
MDhZ/wvyB2bZH6oXgVL2j/0F4S/7D8J/4sXAxvtBvDiI/SFeEsy8X7x/UMv7
9w/AZVYI
          "]]}, "Charting`Private`Tag#173"], 
       Annotation[{
         Hue[0.5097601074635918, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kktIQlEQhm8Py520SnpAD8KMMLEiwcUQLVy0StxHUWKgphCEu5CIVhGh
oiIVVJBFQbQoVwMFgmQmBEEp5SNN8xUkQYsgvGfubA6HOeebmf+f3vll3WIj
x3FyjuPqJ4svPPQ4J6/eXtDARwX3zF2ajs443kfqUUJ3i6P54S6Oo3wUUSda
vXGUE+jz1qOA3tljU4/9FRkvj0uWcsOaKkm8HK7IohKnLoU8LvKOP7Gm35gr
TbwMDrZrL6y1DPFSuH6m3eg3ZImXxKBM7Dekc/Q/geebxnDrXB49/Ptn/JTb
B9riBar3hFmJ+vpvuogqnv+IGv2l0hYoES+GNumBYjhUpv9h3OoWT+k9FVTy
729xJLRgTY5XKR9Ey45ZUjuq4jZ/D6D7u09qLVRRUFBEOu6zPLgoz+5BMNF/
NeODgvgsHwahPvUHQn9jrH+YoP6NbD74oPn8bH4Q5o8xfeCE9CH9QNCP9AVB
X8bPwBDpH2X+QJH8YfVyYCX/yF8Q/CX/QfCf8YowQ/vBeCXw0f4wXgVOab9o
/2CX9u8f1HpIyQ==
          "]]}, "Charting`Private`Tag#174"], 
       Annotation[{
         Hue[0.7458280849633923, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kjtIglEUx79eGK0O4eBgRiAiiYUUFQdqagiiIQKXCkqhoc2hyQpqyKIG
xfpKKgkJc3EJQThENAhmQmlZka98lM/NCInwu+c7y+Vy7v2dc/7/o1hcnVlq
5ThOxXFc82RRw0a/uiNhi+KyEBWUK/t6fPEo3oeaUcJa9Max4YrhgBBFlFpl
3vnKMx4dNuMLt+dy03pfHBmvgE6DpdTIvBEvh1bVb11i/kABF/rEA16i1V0l
iZfBtcB1t3s0TbwUBhILLal0hnhJVGt2e+S2LP1/x9r67GtyMo8O4X0cx6fa
PE8/BaoXwy1P8WSF/0adwH/Esd6Rh5qyRLwI7t1lNRZjmf4H8czCh+yGCmqF
97eY36zbnNIq5f1o1Mu6vPYq7gv3S7x4cYf5bBVFBdtJx1OWBxfl2d0PJvo/
xPiQIz7LB+Gc6lN/IPY3yPqHYerfxOYDcb5jNj9M0PwRpg+USR/SD0T9SF8Q
9WX8DJhJ/zDzB3bIH1YvBzz5R/6C6C/5D6L/jFeETtoPxitBg/aH8SqgoP2i
/YM/2r9/gWBYTQ==
          "]]}, "Charting`Private`Tag#175"], 
       Annotation[{
         Hue[0.9818960624631643, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx9+0mgtX3ElsdqXmI6wkOsnNWEm4IaWEhJCyLBIpkpLPfKSI
Cyntwo3cOCK0GjbzMYu8s7Vebd65Ii6kvec85+bp6TzP75zz/x9ja19de5Ik
STmSJCVOik+0WU6qmr9vsEMLFXPL7HK/1YNX7kTE8GAxVus3e7FIiygafmG0
ZucW19cS8Y6GfPlnf/sOiafg4mbNkiPzkXkRHKrcs5fqA6jh3GHstQS6g9Uv
zAthmt18sdslMy+IE2O67GHrG/NkHHc2K96iMP9/xulLvenaGMFV7f0TGixf
jvlkhes9oD8+ONDy+o6FGt+Hpw2HMLMcZZ4HjU36tsakD/7vwtn6v5WpdBUL
tPdn2O10K2FV5fwR3vv0KbbJOM5p9z08z3KOjAXjKBTUsY5blIcLztP9CMT/
EuJDD/Mp74IFrs/9geivmPqHY+6/k+YDMd8GzQ8ZPL+H9AGhD+sHQj/WF4S+
xA9BKut/Tf5AJ/tD9SJQwf6xvyD8Zf9B+E+8KJh4P4gXg0PeH+KpkMf7xfsH
5bx///3STWk=
          "]]}, "Charting`Private`Tag#176"], 
       Annotation[{
         Hue[0.21796403996296476`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kjtIglEUx78eEjQ0OEiIIDZELSJlJDUcTGhzcWhoCJEMK0qEoKWpFwgV
TWUaFVRDUbS0SOBBk8xQMR+BYGD5KNO0JaIHEn73fGe5XM69v3PO/38UJqvB
3MhxXDfHcfWTxQcqHGMGe6cfJ/io4Mi0uLEQ82M4VI8ybvx5D/3xG+zlo4RS
6/GyU3aHzp16FFF5ZmpIOyLIeK9oWdQODElixCvgnivVMTmaRB4XyuG3Si91
NaeIl8XAvsgzWEsT7wnvp7p0K9sZ4mUw3ye/qnme6X8azT+n48piDh38+xTa
uLxhrfWF6j2gXaK1iduL2MPz47jedmScr70RL4ot59xSfqtM/4Poc1x+6ZLv
qOLfX6NPlvj1BSqUd+NnWR1LzFVxk7+f4KxeE5Y/VlFQsIl0PGB5mKE8u7tB
+K9hfPASn+WD4KX61B8I/alZ/yD0b2HzwSrNt8vmByvNH2X6gJH0If1A0I/0
BUFfxs/CLekfYf5Aifxh9QpwQf6RvyD4S/6D4D/jlUBE+8F4ZVig/WG8CgzT
ftH+QT/t3z8vXFAF
          "]]}, "Charting`Private`Tag#177"], 
       Annotation[{
         Hue[0.4540320174627652, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx98QF/IRN0pIkdxIyOzqXNHkxkcohVoj0RJuVgutZLJaIsWS
vVyQaM2Fiy3tlOViNZqPfNPWWNhr242PckF7z3nPzdPTeZ7fOef/P6Xa0faB
FEEQKgVBSJ4UCZw2LG3ufjlwUI4Ypv9spdl/nXjiT4aE+/rZr/yJA6yVI4rd
ekuW5/gQbavJeEPTmZCIaL1IvFc0ZjTt6Ww+5kXQPHXX3DIWQBnnf8ZMSSOW
mC+ZF0Z/bv/yxOcN80KoznabqjYemRfE6orF3lJViP8/4PVM7rhODOOK/P4W
y8prHDl/L1zvCu1uU+Fx4yvWyPwL1E+2HsT73pkXQENVvdhRLvF/H3rynO53
ywdWy++92PUU7Glej3HehUvWovk2bRwX5PsOqq3DZuNNHBUFU1lHkfKg4jzd
XbDI/xuID53Mp7wPjrg+9wdKf3XUP4xw/0M0HyjzrdH8UMzzB0gfOGd9WD9Q
9GN9QdGX+GG4Z/1PyR/4jpI/VC8Cc+wf+wuKv+w/KP4TLwoa3g/iSbDN+0O8
GBTwfvH+QT/v3z/hAUxw
          "]]}, "Charting`Private`Tag#178"], 
       Annotation[{
         Hue[0.6900999949625373, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8ow2EYx3/+pO2gHDgtSU6ctCG7eHLaiYODgyRN5CBKVooUNyErkT9r
tlI4EBda4ZF/WWab/BpDxqzftvZPXISk/Z7nfS5vb8/7fp7n+X6fcvNAS3eu
JEmVkiRlT4p33LW0PJ9/r0GPGmkMB8xDA+tOuPZkI4n5/rmrHO0sGNRI4J/m
uG4tZcXlpWzEUWsoLDTZt5F4MTSMlVQGig+ReAqebfeHmlYuUMV5ImhZde4U
b/iQeG8of51aug5k5r2i1jSus8WCzHvBZ83C6LAxxP+fsLNMLro3hXFRfR9E
41h0pE+JcL0AOu2NoaPeKOpV/i1GlNIm/X6ceX7ca39sk7cS/N+Nn9M+na0h
hdXq+1MMnVRMTA6mOe/CX43de9mcQat638SCV9/M/G0GhYJ5rKOD8iDydHfB
D/+vJz48MJ/ybvjg+twfiP5qqH8Ic/+9NB84eD4bzQ+1PL+f9AEz68P6gdCP
9QWhL/HfIMj6e8kfaGV/qJ4Cw+wf+wvCX/YfhP/ES0AH7wfxkjB1Q/tDvDRU
3dF+8f6B2L9/FSxQig==
          "]]}, "Charting`Private`Tag#179"], 
       Annotation[{
         Hue[0.9261679724623377, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx1+mbUpyodZKsVygXMzHhdycWjK1RD5TiikiShRFiHLlSqJG
knxkKImk3ThDZLL1lm3lq229GmszbuxCifae856bp6fzPL9zzv9/DF2DDd2p
giAUCYKQPCm+0FrYtep1XUCPHHFsrP/2DQTOwX2XjBh2aK0RyXIGZXJEceo3
P/u9/QRWlpMRwT5D1sJa4wYQ7x0zV1Lq5tJsSLwwDuW1tJmvTlHG3b2iJeHe
S3+8QuJJWDt6ODnbJCLxQlhq3z62qf1IvCC+6ezDB8En/v+M1ZEcTyIQRJv8
/gGN6tDej1Pien4cv849rJ0JY6nMv0evSmuf1kSYJ6Jf95xYNkb5vwtvMpxH
Yx8xNMrvL3GroN+3VBXnvANLdja3TJWfOC/fd7FVv/gy6PlERUEV67hOeWjm
PN0doPyvID7sM5/yLrjl+twfKP2VU/8gcv+9NB9M8HyrND8U8/wi6QPA+rB+
oOjH+oKiL/ElqGH9PeQPmNgfqhcGPfvH/oLiL/sPiv/Ei0In7wfxYvCnof0h
XhzMvF+8fzDC+/cPjB1KSA==
          "]]}, "Charting`Private`Tag#180"], 
       Annotation[{
         Hue[0.1622359499621382, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kt8rg2EUx9/YBZIrlJuNNYobwoVycdxywSJ/AJqmrF34sQtF7MINvZIf
7+TCSqJQoiTlJNZ6axirZcUYs72z9ZKrJaS957zn5unpPM/nnPP9nqp+Z7ct
TxCEWkEQcifFJy4ZF+MOZxAGtVBxxGJNFkRv4CqQiwzW/brFSCwATVqkccqN
qvDrhzVPLlIop/a95s5zIJ6C3+1hsezvgHkJbO0pKvTOuVDDBeJ4/OVTTF3H
SLxX3D4rHz6d9CPxYug1usbGf26ReM9YuWvfFGz3/P8BQ8sv9qG7KEra+wjG
LvtHK8QXpHphnHnOenziGzZq/BDWmJOSyaowL4iGiSfH/d47/5exz6rYtqQM
NmjvLzBuqF+dLlU5f4KPHUcuv+UDF7T7Dn6XHM4Xyx+oK5jPOm5QHrKcp/sJ
RPl/C/EhxnzKyzDA9bk/0Ptrpv6hmvu303wwzfOt0/wQ4fmDpA9csz6sH+j6
sb6g60v8V/Cz/tfkD8yyP1QvAWH2j/0F3V/2H3T/iZcGifeDeBlo4/0hngq9
vF+8f7DC+/cPI79RJQ==
          "]]}, "Charting`Private`Tag#181"], 
       Annotation[{
         Hue[0.39830392746191023`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1klsow3EUx//hUZLLpOzBw/9BHiwbyYOjhlyi3PKwaBbLC/NEeXArzyyL
udQmpZSUB0XoPKxhzFqG0dRcluv859Gtpf3P+Z+XX7/O7/c553y/J99kaelN
EgShQBCExEnxie2HJTbDfhDMckjoWFo1tWmCcOZNRBTbDc9TG9OXoJXjHZvC
6fG5yDksLiTiFa0rIzm2MR8Q7wUPNXG1OOhm3hN26Z3i79o2yDhvBDPrrr0O
/QQS7xFTvjMOsn72kHj3GB46URfOnyLx7nBnS7dpP7pA+n+L2pe9jdzjENrl
9zfYoKoaLGq+R6p3hWFJ1zpui2CxzA9gucsvdlifmefHr9DfsFt84/8ezLak
dtZURlEjv3dhjzQQNj58cH4XG0ONKmNaDGfk+zpOtKl9/a4YKgoms45OysMo
5+m+C/X8v4z40Mt8yntAqc/9gdKfjvqHUu6/j+YDZb5lmh+qeX4/6QN5rA/r
B4p+rC8o+hL/Ecysv4/8gcla8ofqPUGA/WN/QfGX/QfFf+K9QzfvB/GiUMH7
QzwJZnm/eP/AxPv3D59HSTc=
          "]]}, "Charting`Private`Tag#182"], 
       Annotation[{
         Hue[0.6343719049617107, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kklIglEQxz+KsOgQhR06lSBEhyDKQxA0hwpsOUQEnVpJsYWKoItRtxaI
aAFLo1I6RHkQsksectqILI0ykBZLRRHNpQ5R1/Cb+ebyeMx7v5n5/0cxMN6h
yRIEoUIQhMxJ8Y05nv02eXMAtGKkUS7DtfyjD/C4M5HE4dCb3Zr0Q40YCXxr
6drPkb3ClikTcWyM6RcbinxAvBi2mnWFFeWPzIuiZrDSnL65BhHnjqBiZsg5
f3LMvDAWnJ07ZTsWJF4IMbdy4vbzAokXRLuq88qW94j034+/Jd3t2XvPaBTf
v6BztEVvlQWR6vmwX9nj9a+EsVrkP2F9U0o7eRdl3gPuvhuWjcY4/3ehdanv
ZzaSwCrx/SWaNrTraluK8w5cmC61Ff+lcVW8H6La640aTr9QUjCbdbRQHqQ8
3R0wx/9riQ+bzKe8Cw64PvcHUn8q6h/quH8dzQe9PN82zQ8Onv+B9IEk68P6
gaQf6wuSvsQPg5L1vyd/YIz9oXpRmGL/2F+Q/GX/QfKfeAkI8H4QLwkjvD/E
S0MZ7xfvH0j79w9A8Ue6
          "]]}, "Charting`Private`Tag#183"], 
       Annotation[{
         Hue[0.8704398824614827, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx998FSUXxAURrYWrhdDEKRe0lJrydclM75WPC1Irk5JQPm9G
NEotSpILreQkkXeNCNPKtO1lWeNF7qSlvee85+bp6TzP75zz/5/i3sE2a5Ig
CGWCICROii8syVx2D83I0K+GgmXZ5b91NTJceRPxjh35ReJWYxgq1Yih77gr
13kQhLXVRETRDI5QZkEAiPeG23t+adzzyLwITpxYSv0Lt6DivC94b60fydKf
M0/GlN2KvNM/F/NCqHPMKUsfh0i8IDaJoien24P0/wmN6S1mY88DOtT3fjQd
2iJxawCpng+b51OjDZNhrFD5d7hqy+jD+CvzbvDNtyLPpkX5v4T3w9790akY
GtT3Z7hhKehsHfvgvBsn7YWX388KLqr3HZRcP9XTR5+oKZjMOm5SHi44T3c3
2Pl/LfFhjfmUl+CW63N/oPVXRf3DCvcv0nxg4vnWaX6o4flvSB8wsD6sH2j6
sb6g6Ut8GQZY/2vyBz7ZH6oXASf7x/6C5i/7D5r/xItBgPeDeO/QzvtDPAV0
vF+8f6Dn/fsHxMFFCA==
          "]]}, "Charting`Private`Tag#184"], 
       Annotation[{
         Hue[0.1065078599612832, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx98wN4oUF3OnRWmRNhdK6yjKlYuRK5QstgshKfm4JfKREo3I
R7Eo5evCUEckW828iGUtGa/3NWOocSntPec9N09P53l+55z//+Q2d9S0JAmC
UCAIQuKk+ELF21nfN6pAqxoxdP2E4opJgQtfIt4xO8vobDDKYFYjiqJ+5bG6
X4K52UREMIjTaC18AuK94u/A4Nve4gPzZKxaHpF2IgFQcT4JR3UnnTPNIvOe
0eBvyj/qOmZeGBsrXnY2PT1IvEecio+162wnSP9D2L1w6A6nXqNTfX+Pp/KQ
WOsKItW7wzL7lZTeFkaTyr/BDHPe94TxhXkiHiRn2gIdr/zfi6vWwqI6QxSL
1fenCLe+8eHyD8670Z7TW/l3FsNJ9b6Ol/vn5srtT9QUTGYdlygPWp7ubmjh
/6XEBwvzKe+FNa7P/YHWXwn1D2ncv4PmAwvPN0/zwy7PL5I+4GB9WD/Q9GN9
QdOX+M+Qwvr7yR/YYH+ongw29o/9Bc1f9h80/4kXBQ/vB/HeQc/7Q7wYbPF+
8f7BJ+/fP1RiTQM=
          "]]}, "Charting`Private`Tag#185"], 
       Annotation[{
         Hue[0.34257583746108367`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx5+k5IZLKYq4IBcblrarc6Epi9RoPm7kc7tBrtzIBXIhF9oF
I0ooX0uRj17hhJRlY1iTkoYZttmUEBHtPec9N09P53l+55z//2Q2dhhb4oQQ
uUKI2Enxil/tmKxZCEGrHBEMJL5lpxpC4HLGIoxW/2xPuioIhXKE8GMgqy+/
/gnGx2LxjFrDUf/awwMQ7wkPN0U07/yOeQEU66MN2HEDMs7px7K50qHtOi/z
7rHXmjG2rDpm3i2OvDfvi64V5vmwtmHJ9G1eQ/p/jcHVTpspx4U2+f0VStMz
ldWeS6R6XtzodhZJ5T4skPkXWK1LGdQY/Ug8Nwq1fnLL88j/HVhjb0sr3g2i
Wn5/gNtnmpKkhBfOS6jbs5j09ggOy/cF/K3YMZ8uRlFRMI51nKI8/HGe7hIo
/7XEB4n5lHeAietzf6D0p6H+oYr7t9B8sMnzTdD8MM/zu0kf8LA+rB8o+rG+
oOhL/HvoZ/1PyB9oYn+oXgDi2T/2FxR/2X9Q/CdeCH54P4gXBmV/iBcBL+8X
7x988v79A5qoQ6E=
          "]]}, "Charting`Private`Tag#186"], 
       Annotation[{
         Hue[0.5786438149608557, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kktIQlEQhi8S7VoUBbYKIbAHQVhCkDBE2yCodFMQFEW4SNJaRIu20YMy
kB64aNHGRRRZC0kaKIhMjcywB1KaaV29XQ2EFkKEd+bO5nCYc76Z+f/RjdkG
JjSCIDQLglA+KQoYnZttaUjmYVIJGcPTaB5cyEM4VA4JC+GcydYnQ4cSOSwe
1TUmhyXY3SmHiOKWPhg7FYF4X3iy6fLmrRnmZfBlaUi+X38HBRf6wFLwsNsy
H2deCtMB97W2Psq8JB774EzvuGBeAg3nn/PL8irS/zhW+WPpg9or3FbeP+Nb
9YpXKz8g1YuhU2zrGel/RYPCj+K3Zq2t0pFC4t1h8Wfcbzd+8v8AesbMTVZL
FtuV95f4Z/cbf4MS532YNGUWI04ZN5S7B3W9ozOt+3lUFdSwjnuUBzVPdx8k
+H8X8eGX+ZQPgFqf+wO1v07qH7Lc/xTNBy6ez03zQ4LnvyN9oIL1Yf1A1Y/1
BVVf4qfghvW/JX+gJkT+UL0MPLF/7C+o/rL/oPpPvByUeD+IJ8EX7w/xZHjk
/eL9gwjv3z8QXFGD
          "]]}, "Charting`Private`Tag#187"], 
       Annotation[{
         Hue[0.8147117924606562, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx1+zm9241O6kllouyNfc6ExcaLnycYVdqMmF0m6W0iiTJd+K
RlvcIheGGOkU+Vg2kfK5ZBtv+zKmKYWlvee85+bp6TzP75zz/5/Czt4mk0IQ
BK0gCNmT4gNzWuynd+pP6JIiiYZQVZ89lAK/LxsJ7F8zPEX0KSiXIo677sb+
tO4DFheyEUXlw9BIq/MNiBdBiz3XequOMU9Ep/K4wPrzChLO94KjGvVmvjHI
vDAute8ZivbvmBfEqLfSVWLyMe8Zz09uxG3NGv8PoHk7T3W2eoAO6f09zuwY
ExtfV0j1brDG5vYfph+xTOJfY/FYh659MoTEu8SA/tsMsyL/92Km5/czHY9i
qfT+CJXztvW2qQTnPRgz1U6sW5I4Ld1XcEBVp2hzvaOsoIJ1XKY8yHm6e0Dk
/9XEh8wc8SnvhR+uz/2B3F8F9Q9a7r+b5oN6ns9J88Mgz39J+sAw68P6gawf
6wuyvsQPg4P1vyB/YJz9oXoibLF/7C/I/rL/IPtPvDjs8H4QLwFW3h/iJaGB
94v3D/6aaf/+AQnITeI=
          "]]}, "Charting`Private`Tag#188"], 
       Annotation[{
         Hue[0.05077976996045663, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kstLQlEQxm+XFq0y6h/otYkIooLEFrNz5aYokFY9JSho0YvKSHIR9KBr
WVSIBdWiIoho46ZZBEGUIUpPVJKr1sVn5s4W4Z25szkc5pzfzHzf1AyMdw2L
giA0CIJQPCmymFFuSs9NebCokcah7bKzYGUevI/FSOIcLIohyy+0qpHAwYVG
Y8yUg/29Yij4KdZdRh6yQLxvvOt5rl/9SDEvjjPZUr97VgEV9xjFQkmqakGK
Mk/GFbAGc/Nh5kVQeh37KhgDzPvEqWqz3FGL/D+IRzG9cnV9gbvq+3ecOHnZ
XH/zItV7weUOW4Vz7R1bVH4AtybNBsdxBInnw7ijSe5PxPj/PR6IflG3qGCz
+v4W7YZOqbszyXkPWpfcUrQ3jZJ6P0VdeybUt5NBTUGRdTykPJRznu4emOb/
euKDjfmUvwcX1+f+QOuvjfqHDe5/hOaDJZ7PRfNDF8/vI30gHCV9WD/Q9GN9
QdOX+DI4Wf8n8gf+2B+qFwc7+8f+guYv+w+a/8RLgLYfxEvCPO8P8dIwyvvF
+wc/vH//JplLXA==
          "]]}, "Charting`Private`Tag#189"], 
       Annotation[{
         Hue[0.2868477474602287, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1klsow3EUx/944Ul48LIUpdzK/VLKyYt4UNI8IJGyFOVliQcPc0mxhRQm
RdSWywPJasR5WGI1WpvYMM19s9mW8KLQ/uf8zsuvX+f3+5xzvt+T3tnX2BUr
SVK2JEnRkyKCGR5Fe9nkN6jkCGFlrnr1uv4bzmzRCGLGWoqybv4LiuUIoGG3
Zvm35xMW9dHw42ypW6d0fgDxfGjLGtYoryLMe0HTX2AkHP8OMs72hHdDzbjj
eGXeI7aoew+38x6Yd49tFQk592oX87y4eTI6YBg75f+3OKMvnBuca4AF+b0b
L/tP4+INJ0j1LtGk1UYsqVdYJPOd6NLp3TEmLxLPjjfGjllF9TPSfytaffl7
T4l+LJDfW7B8XVX7kxTkvBmTq1o9mqoQTsv3dRx37LtgKoxCwVjWcYXyMMF5
uptB/K8gPgg+5a1wzPW5PxD9lVD/cMH9d9N8cMDzLdH8sMXz20kfKNogfVg/
EPqxviD0Jf4jNLH+5+QPvLE/VO8Fjtg/9heEv+w/CP+JFwAj7wfxgpDG+0O8
EIj94v2DTN6/fyHQSKU=
          "]]}, "Charting`Private`Tag#190"], 
       Annotation[{
         Hue[0.5229157249600291, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kj1IgmEQx19sCFxqaQgi0IZqiESLHIKLVnMJCwpKCLSaooZaGoqgoIY+
DPpALCqHBmmoIC05woYELa0w+iLjVTFeMYs+pCHC9+695eHhnud3d///afqG
2m0qQRBqBUEonBQ5jD2N3bqv82CXI4sGR+WRZykP4VAhMlgnVGh7oz9gkEPC
pP29Y2z5G9bXCvGKZdrx4oD4CcRL48h8TicGP5iXQnRuq0ssOZBxoQTO6cXS
iSqJeSJ6LLmvrZok815QP2t1dPuemBdH20T/5WE0wv8f8bzN79Wa9mBVfn+H
FvXwSXPnKVK9GN7EjT7Tyg3qZf41PqTuW8unn5F4EbRmW8z7jgTS/yAe20br
t11p1MnvA5jvavIPRiXOe3GyvqdoUZPFBfm+i64/d+x35g0VBVWs4yblYYfz
dPfCFP83Eh++mE/5IPi4PvcHSn8N1D+Euf8Bmg8iPJ+T5gcNzx8hfaDRTPqw
fqDox/qCoi/xRThg/S/IH9hgf6heCs7YP/YXFH/Zf1D8J54EEu8H8TJQzftD
vCwo+8X7B1e8f/9VeUl/
          "]]}, "Charting`Private`Tag#191"], 
       Annotation[{
         Hue[0.7589837024598012, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx19LCrvyMVeS1tRwsczFXJ1ys+RClHbBlXwVJSkpLXtdKCJT
LtDKmPJ1ZbXWaJ0LXGC05isybV7m1TTSktiF9p7znpunp/M8v3PO/38qu4ba
ejSCIBgFQcieFJ84/Ti7VWH4g14lUtjgKxPtsV84D2XjHYM744XWkl8wK5HE
VYduQzz+gZXlbLxh62SVrT/zDcSTsTH8k2M5SjMvgcWZK49c/QUKLvSMZ7rB
4K6YYp6EXmffvdckMy+OU+ZIvn8mzrwYZvTpbvvINf9/QK0gzvc0ISwp7++w
86ndZb31IdW7QTlhcBu1EaxT+JfYsbCG+qUoEi+MTk+wYECSkP6f4GvRXstY
jYwm5f0hnm/mNe3PJzkfwIlY82l5bgqdyn0bx4ZrTxcdH6gqqGEd3ZSHUc7T
PQB2/m8hPoSYT/kTkLg+9wdqf/XUP9i4/36aD154PhfNDxqeP0z6QCnrw/qB
qh/rC6q+xJfAz/pfkD8QZX+oXgLK2D/2F1R/2X9Q/SdeEtZ5P4j3Dge8P8RL
gbpfvH8wx/v3D4MZRFU=
          "]]}, "Charting`Private`Tag#192"], 
       Annotation[{
         Hue[0.9950516799596016, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kklIQmEQx19dlCCIjmEHowSpg6RUpyaKCopIqkMHQRKSCFuOLVRChxYI
QiuyOrSc9OAlCIVgoggJVIQgaDkUymt55UILGRnhm3lz+fiY7/vNzP8/WttY
z2ChIAh6QRDyJ0UaO6xvnvPZHNjlSOKy0VY1UpeDSDgfrxjwNZmrrb9glENC
zARmOv9+YMuTj2d8aSt1T2uyQLwnNHfZLOvnX8wTcXxY0vWpP0DGhROY9b77
vz/TzItjuWti7bhFYt4DdntUkaLmBPPucd65UWHX3fD/O2zc/tSJ7hBsyu+v
cVFfllEf7CHVu0Jn4c/cSTKKtTL/EotHK7Pi/i0SL4apydTtkiGO9P8CI97Q
juvoEQ3y+zPULjj8qi6J80EcaA/UmMQ3XJXvXuytLz0smUyhomAB67hLeejh
PN2DYOH/DcQHDfMpfwEhrs/9gdKfifoHNfc/RPOBg+fbofmhkeePkT7Qz/qw
fqDox/qCoi/x46Bh/aPkDwg+8ofqiTDF/rG/oPjL/oPiP/EkOOX9IN4rKPtD
vCSs8H7x/kEr798/h5RDvw==
          "]]}, "Charting`Private`Tag#193"], 
       Annotation[{
         Hue[0.2311196574594021, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk1LQlEQhm/tWgS1KejbVUkUkhEJyQjRLgpKCleJUbiRcB20yB9gYklZ
F8pNuIlCIoRisIIQNIU+wIoyDVOuWURCIFp4Z+5sDoc555mZ9x2VZWlqoVYQ
BLUgCNWT4gtLzknT8csfLMpRwHjf48m2+w+ikWrksWPEpO4/qoBWDgmzd6FM
RV8G71Y1ctjl+BA0oyUgXhaL6Z+KLvrLvAxa3fMBUSqCjIu8YcOledVx+M28
NF7n5sY85gLzXtHUE2zqqn1nXhLf2sYPfNln/v+EZ6N+7YQYg035fQJT25aa
0xUX17tHr0405gNhHJD5N7i5ofep9xNIvDiaW7ujM8sppP9hfGg0DKkM76iR
31/g7N55va1O4nwQO33a6eTVB67Jdz+6oFe02z9RUbCGddylPDg5T/cgtPP/
YeKDkfmUD8Mt1+f+QOlvkPoHD/dvpflgnefbofmhQaT546QPlFkf1g8U/Vhf
UPQlfhpCrP81+QPN7A/Vy4CN/WN/QfGX/QfFf+JJIPF+EC8PLbw/xCtAjPeL
9w8qvH//ialENA==
          "]]}, "Charting`Private`Tag#194"], 
       Annotation[{
         Hue[0.46718763495917415`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kkEow3EUx39T5IA7QuNCJM0OlLylHCgOKK7U/lFYuUoULbWGdhobc9mB
m8Qah1dG7a9Z+IsmYaaxmaEpRaL93/u/y69f7/f7vPe+36cfsvSYc4QQNUKI
7EnxjmcZ2+hclc4kqZHGhda6TsePMJ2EspHCmYp9h29OmBrVeMGW6UTXwewf
rCxnI4Hn0drxHcsvEO8ZZz+wb/D6G4gXxztZMRVdfIGKCz1iics9FrZ8AvFi
2Hxk7s4PvDMvioUOgzUhJ5h3jwvH1Wv1N1H+f4M6qX3g8VYBp/o+ghLqg2W+
La53iZlVVyQ5cogGla/gviTEjvcKiXeKHfa2UPFhFOm/jJt2Z6A3GMcG9X0A
CyYmr3OPkpz3o9XTv1i/8YpL6n0DH4zlnr2RN9QU1LGO65SHOOfp7od5/t9E
fMhjPuVl8HJ97g+0/ozUP2xz/8M0HyR5PjfND7s8/ynpA6WsD+sHmn6sL2j6
Ej8GRtY/TP5AJftD9eLwxP6xv6D5y/6D5j/xXqCJ94N4KZji/SFeGmy8X7x/
oPD+/QMx30Xa
          "]]}, "Charting`Private`Tag#195"], 
       Annotation[{
         Hue[0.7032556124589746, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kj1IgmEQx18Fl96hoaVo6YMIi0rSQejjpHCIiCAqMFwqFIcoF4sojIgg
oiBosQgsnIKGoCFcvMoWQU3oi8BBU9TSLKJMISh8795bHh7ueX539/9f/dTc
iEUpCIJaEITySfGBBceGKWtSGqxS5LHbU4xVapSGULAcObx4VRnXzxQGrRRZ
1DXcOcxpwbC/V44X7Jvp2tIf/QHxMij6xXB/7heIl8Iaoecre1ECCRdMojPT
/NyuLQDxEnhajHqXTJ9AvDjuGhdsY64c82IoztuHogNJ/h/F6nTLdVXpEVzS
+yc0+7+dqx3I9R5wsNa8eNLkw06Jf4uWWbVr1H2PxIvg+bJ1u1aMI/0P4E1F
3/TEcAo10ns/enoskbeVV857Uby6HG/dfMMd6X6MisbGp/zkO8oKKljHQ8qD
kvN094KK/+uJD27mUz4AIa7P/YHcn476BxP3b6P5oI3nO6D5wc7zR0gf0LI+
rB/I+rG+IOtL/ATI+ofJH1hjf6heCurYP/YXZH/Zf5D9J14W9LwfxMuBj/eH
eHno5f3i/YMf3r9/bWE3yA==
          "]]}, "Charting`Private`Tag#196"], 
       Annotation[{
         Hue[0.9393235899587467, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kt8rg2EUx99tV67EJhdCblYrF5pdiHLepSgXkgvJhdpqGlkLF8ofwIUV
hvKOpCRxofy4WS3Hj9paIVojszLtR9hs4mIY0d5z3nPz9HSe53PO+X5PndXZ
Y1MLgmAQBKF4UryhdsjYIbk14qAcWbT/mOuvBzXixXkxMjgfOL53JdRioxxp
1EVq3KpSteiRivGMjnhoazQtiMR7wkzZb0ul+g+Il8Id/eHE5F4BZNx5Agc8
+6rPrzwQL44zJ35TyccHEO8Rz6y9nV0jOSBeDN/78qt2X4r/R1G6rW6XqqKw
LL+/Q61heurU4ud6N3ggmfdWLAdolPkhXLKVP4QXQ0i8KxxbMzk3u2NI/4Oo
t7RJtnASG+T3Z6jPR57E5hfOe/E7qWmND7/inHzfRr/jaLysP4eKgirWcZ3y
EOA83b1Q4P9NxIda5lM+CNVcn/sDpT8T9Q+z3L+d5oMNnm+V5ocunv+K9IFd
1of1A0U/1hcUfYkfBxfrf0n+gJX9oXop8LF/7C8o/rL/oPhPvDRU8H4QLwML
vD/Ey4KyX7x/oOP9+wfuXz5+
          "]]}, "Charting`Private`Tag#197"], 
       Annotation[{
         Hue[0.17539156745854712`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1klsow3EUx/+2yYsXl+yBl60oe8FckqzzlxeXXKI9WGm1IrxQKHnwIPGg
uZRySS6FTCnytKSjprTahG1KKVszmc3ckzS0/zn/8/Lr1/n9Puec7/doLL0t
HQpBEPIFQUicFC+4Z0s+yXKrxE4pYugJGAfMqyrR7UpEFPd3AqdtapVYLEUE
qzL/Bs3lSnFpMRFhbDTtbsdSFCLxHjDHmjo/YRWYd4/xx7nWn404SDjXHYaL
ht6GHd9AvCBq/F/H6dOfQLwA4qHvpF37CsTz44UimnWrD/P/G6w+zKjt0fph
QXp/jX1j9vlgmRuo3hWOjPbX+NTrqJf4HiyoqwylTFwg8c5Rvak7Uuhukf47
0eidMmyZQlgovXdgRXeoKfsjzHk7Kr2T75b6J5yR7jYcXxlayW15RlnBJNZx
jfIg5+luh18P/S8nPpQyn/JOaOD63B/I/ZVQ/5DH/XfRfNDD8y3T/DDL85+T
PtDM+rB+IOvH+oKsL/GDoGX9z8gfeGd/qN49pEXIP/YXZH/Zf5D9J14EDLwf
xIuCvD/Ei8El7xfvHxzw/v0DY7Y5cQ==
          "]]}, "Charting`Private`Tag#198"], 
       Annotation[{
         Hue[0.4114595449583476, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8ow2EYx3/+bTg4kCVJOTjIWmJlND0/Tv6TEz+5WJNc5qDlgAMHOWAl
hTlMScTkxkiPIlmNFlGK/Nla1mY0B0TRfs/zPpe3t+d9P8/zfL9PUa+tw5os
SVKJJEmJk+IdLdOjrZF0jdynRgwHbfvxuts0+dyXiCgq+lqbvSlNrlAjgmta
py7VkiovLSYijMr3at5acYpMvBccVsbWDc4k5oWw9Xm+fnvpD1ScL4grR1lG
7ewPEC+AvYaapy/9JxDvCfvNU3HZEQfiPaLWBLqGrQj/v8Pg5MGvo+oZFtT3
txiaOTNXZl4C1bvBjs5s18neOJSr/Cv8yNdk2F8vkHh+NF+3D33s3CP992LB
SM5Ay0MQy9T3x1hU3ta16A5z3oOHpxPVu6Wv6FDvG9g8PTdjaHxDoWAS6+ii
PIg83T1wwP9NxIdC5lPeC7lcn/sD0Z+R+ocH7r+f5oMsheZbpvlBM0vz+0kf
iLI+rB8I/VhfEPoSPwDdrP8F+QNu9ofqhUBh/9hfEP6y/yD8J14ENnk/iBeF
Ht4f4sVA7BfvH1h5//4BbcEtDw==
          "]]}, "Charting`Private`Tag#199"], 
       Annotation[{
         Hue[0.6475275224581196, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxVkl0og2EUx59mTLgSKSm5kHaDfDUXOu+WiZILIrWrTST5uHLlI24oablQ
hil3Pmq72J0LnfJRxmuRNqkRec1mMysuUKK957wXzs3T03me3znn/z9ljrHO
fp0QwiiESJ8UKRztPVrYsBqkATWSeBtyGzIKDNK5nI4ENra02odnsqRaNeKY
1z6/MunMlNZW0xHDy0rxY2zWS8SLYn53OOLa0TEvgqHCkmD0REgqTlbweLr6
48X2A8R7xMCB77lY/gTiPaCnS9Zbft+BePfY5uyxeCuSQP/D+C0VrY90KuBS
399geZM9OzgRBKoXwhyrw10/tws1Kv8KM7dLi2f9p0i8C6zquBvyNYSR/vux
0LE8uNinYLX6/hBbbN7x64EY5/fw0+95SuS+4pJ638Hn4f2pKssbin+Rwk3K
g8J5uu/BF/83ER/MzKe8H/K4PvcHWn911D88bVH/gzQf6Hg+N80PEs9/QfqA
wUz6sH6g6cf6gqYv8R9BZv0D5A+csT9ULwJ37B/7C5q/7D9o/hMvDtp+EC8B
Jt4f4iVB2y/WDbT9+wNf0DH3
          "]]}, "Charting`Private`Tag#200"], 
       Annotation[{
         Hue[0.8835954999579201, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxVkk8og3EYx1+TWdsFF05E/iQUmyQOz1tyVkrJn2LLmsgODhykxUkOHGaZ
dlitRC5qqeHw1Iwao83f+XOgMeQ1byJxob3P8x48l1+/nt/v8zzP9/sUm+3t
AxpBECoFQUifFDKuFG6N+6d0olWJFC7XLdjL23TiYSQdErrWpNnQRrZoUuIF
B2smJju2tOKSOx3PuF/aGjRYskTiPWFu9/ppbyCTeUn0uZw9sVCGqOAi9xjq
K7OMVv4C8RJo1nS1XAz9APHu8MmdNxcb+QTi3aI2+DWtb5eB/t+gv1MuqB5O
wqLy/hId+hLbayoOVO8cT0xd87umABgV/gnm28T7U98eEi+KHw2OsbPtK6T/
YcwwtXmdjwmsVd7v4MOMteK96Jnzm+iJNx/nSBLOK/dV7BeDK1VNbyj8Cxm9
lAcz5+m+Cer/RuJDgvmUD8O3kepzf6D2V0/9g4H7t9F8cM3zeWh+cPL8UdIH
AqwP6weqfqwvqPoSPwFW1v+I/IED9ofqJWGV/WN/QfWX/QfVf+K9gLofxJNg
gfeHeCnw8X6xbqDu3x8GIjeS
          "]]}, "Charting`Private`Tag#201"], 
       Annotation[{
         Hue[0.11966347745772055`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxVkt8rg2EUx5+WH5NyZTdKGiFX2FwIdd79Ay7cuqCVRStcSH6lJCkuzFwY
UWM15oLiQrs6fqzWataiZHoTpnnZzLjYCkl7z3kvnJunp/M8n3PO93uM1qGu
Pp0QokEIkT8pMuiWK/cOsUSyqZHGGtfCuHmhRLoI5yOFtfbgcHFSL5nVSKKi
VDxXJIql9bV8vODAZPOgPFMkEU/Br0CrszxYwLwEvrdt/+6f6CQVF37C56PA
7OikYF4cIwcn4cXSHyDeA+7Y2709d1kg3j1O6HfnLY4PoP8yVt364rk5BVzq
+xguG8o+jVYZqN416o57bb3OUzCp/Cv0jI28GabPkHhRDNQ3eD+lGNL/EH53
T82u2uPYpL4/x5usN1cYUzjvR/2m97ExnEKHevfhiqWjs870juJfZNBNeVji
PN39UMD/W4kPl8ynfAiyXJ/7A62/FuofVrj/fpoPBM+3QfODh+ePkj7Qwvqw
fqDpx/qCpi/x4xBl/SPkD6TZH6qXgFf2j/0FzV/2HzT/iZeEF94P4qWgmveH
eGnQ9ot1gy3evz81Vz29
          "]]}, "Charting`Private`Tag#202"], 
       Annotation[{
         Hue[0.3557314549574926, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxVkksoRGEUx69Xxs1mYmOi8cjCowjFQp1bsvFaSEg2lPdCysJjNgql2chC
M8JMUqJRopSisyCajDEYb3kbg8kMEQpp7jl34Wy+vs73/c45//+Jq20trQsU
BCFJEAT/SeFDe6KlI/ZblOrleMapKH3u3Joobdn84UETaKpWtKKUKccT5k8a
FivVYdKI0R8P2Gce2Ek1h0rEc2NEyXV42X4I81z4kt29rV0OkmSc7RZdGSbV
bk0A825w825EPTzzA8S7QnvifkJ18ScQ7xKLzt4Of7degf6foVMMlr7HH8Eg
vz/G94/dlEjnBVC9A2wTekpOVBuQIfP3sFNjbNpZWEbiOTC6S/djWj9E+m/F
9op53br3GtPl96uo729oSRtyc34JTxd7v8otHhyU79N4j3mz8cleFP6FD82U
ByVP9yU44v85xIc+5lPeCs1cn/sDpb8s6h8Kuf9Gmg8GeL5Rmh9iPml+B+kD
56wP6weKfqwvKPoS/wa2WX87+QNe9ofquUDxj/0FxV/2HxT/ifcEBbwfxPPA
GO8P8Z5hgveLdQMb798fE6k67Q==
          "]]}, "Charting`Private`Tag#203"], 
       Annotation[{
         Hue[0.591799432457293, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxVkl0og2EUx9+WtIYrN66UYaWEfIxC502KSMlyLZqPUmTIhZSQWIxczVpt
FOXGha1l+TgkF7TZarWSFds0kzUudmE3m/ae8144N09P53l+55z//5SNTA+M
KgRBqBIEIXdS/OD5S1HbSnOhOCZFEsV+g1edKRC9nlwkcKHctjOlKxAbpPhC
u7baZ2lViZb9XHxiptbu3r5SisSL47JzssYRyWdeDNfWP15vXXmihPO849Dp
2aChS8G8KN4Uttt03VkgXhi97sq49iINxHvDo9Rj3b0qBfQ/hMq+9LHelQCz
9P4Z1zFV5DgIA9UL4rXDvFS56IF6iR9AK6pLIjNOJJ4fO3o0nbN9QaT/D7jj
bwoNzEWwTnp/h4HliV9jb5zzbtwc16f2thK4K91PUJMtzatQf6PwL37QTnmo
4Dzd3bDB/1uID17mU/4BVrk+9wdyf43UP5i4/wmaD3w8n5XmBxPP7yd9oJj1
Yf1A1o/1BVlf4kfBxfo/kT8wzP5QvRgY2T/2F2R/2X+Q/SfeFxzyfhAvAfO8
P8RLAvB+sW5wyfv3B3WzN6A=
          "]]}, "Charting`Private`Tag#204"], 
       Annotation[{
         Hue[0.8278674099570651, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxVkl0og2EUxx+WJBaLWu0Ci4WkZEJcnLfEnRspuZi0EGX5LCKRWtGk3Sgf
S6LEhSIX2o2j5GMZrWi10tqa1mTNIvLRor3nvBfOzdPTeZ7fOef/P3rzYGtP
qhCiTAiRPCnieFI6PmMaVku9csSwOxfGNDVq6cadjCi22FS2bWuWZJTjGWsP
9Y2W7kxpbTUZTxjYmNTbfRkS8SIoNtYzXbF05oVRBdn9xoM0Sca5H3F2f2sn
Ua5iXgi1Re8GzYhgXhALahK6rpIfIF4AF3KulrXN70D/H9A6FSg0XcdgRX7v
Q51/aMDUHgKq58UPv7Fz8c0DVTL/Drd+jy6bRneReB4sbmq4SPHeI/134XS+
dG75CmKl/P4MXfN139VpEc47scO6txMfiKJdvu/hseN1qUL3guJfxHGT8uDk
PN2d0Mb/64gPZ8ynvAsmuD73B0p/1dQ/mLn/PpoPPnk+B80PBp7fQ/qAg/Vh
/UDRj/UFRV/ihyCP9b8lf2CO/aF6Ychg/9hfUPxl/0Hxn3jPUM/7QbwoKPtD
vBiYeb9YNzjl/fsDmWwqWg==
          "]]}, "Charting`Private`Tag#205"], 
       Annotation[{
         Hue[0.06393538745686556, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxVkl0og2EUx19raWmjJjfbFXKB1PLVpJyXRigpbmguWCyyfCTFtuLGV7vZ
uPCRCzc+diM3LkgdJaFGq0mJi8kMbc20WGpKe895L5ybp6fzPL9zzv9/8i2j
HQMKQRCKBUFInxRxrFx9qDZ6s0WrFDEMD/8GFbZs8dqXjiiqWr9KXw41YoUU
EcwzOBZ6XGpxYz0d79iUclrOE1ki8d6wfn9SW/ajYl4YPzWY1O5lihLOF8LR
2sw5XY6Sec94apiCg7oM5j2h3dQ13OxJAfGCGLrYWZye+Qb6/4ixXkf70kgc
1qT399gdsrvMWS9A9e4wd8h30rQdgHKJH8BljcbaWeNG4vnRPHusC/YGkP5f
oW2sUd8884QG6f0ZlnhMuy34yvkjLFwZv3W2RdEt3b3Yr5iYb9B+oPAv4rhF
eejjPN2PoID/G4kPRcyn/BUMcH3uD+T+Kql/uFRT/4M0H+h5vk2aH6w8v5/0
gQTrw/qBrB/rC7K+xH+GE9b/hvwB2R+qF4Yk+8f+guwv+w+y/8SLgI73g3hR
UPL+EC8GEd4v1g2qeP/+AA2kKUA=
          "]]}, "Charting`Private`Tag#206"], 
       Annotation[{
         Hue[0.300003364956666, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJxVkl0og2EUx1+ar/kqF9wpd1zQMuGG82qKKWnuFIWQcrEitNJcuBtqroxo
24WPibjQZD5OUmo1i9RCkjXG2ppJMy58tPec98K5eXo6z/M75/z/p6RX396f
KghCmSAIyZMihusn1nfLfb44IEUUq2fLu43WfPHck4wI7h1uhA8DeaJaijC6
MpWr8e1ccXEhGSG8VZj6MDtHJN4LeuP3NeMpSuYF0bRZOP+7nCFKOM8j+n+2
XvUxBfMC2DR2duDMSmWeH9Fw3drz+Q3Ee8Cp6Eq93pkA+n+Hw0e7jo7RN7BI
72+w6DZxI7iCQPV8OKdt0O3ofFAp8a/Q1en2qNRm5l3gRKAlZI9eIv13Y5tP
oy9I96NKen+KGls87cnwzPl9NFxPljdWRNAs3R34NTRfPKB8ReFfxNBGefjg
PN33YYT/1xIf6phPeTc0c33uD+T+qqh/mO6i/gdpPrDzfEs0P5Ty/BekDxhZ
H9YPZP1YX5D1JX4AtKy/l/yBF/aH6gVhhv1jf0H2l/0H2X/iheGY94N4EXDy
/hAvCvJ+sW6wxvv3B2TYP2Q=
          "]]}, "Charting`Private`Tag#207"], 
       Annotation[{
         Hue[0.5360713424564665, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx99WTAmjlhvLR6MWRT7yUTrvJUlCLnzckGlKXMiFC5OkURRX
Pi8kigtFinahc6FkNbOxZHGxNfnabBK2kGnPOe+5eXo6z/M75/z/J7dnqMWo
kiTJIElS/KR4Q9dH++zktEbuExHCgoN6daJJI5/b4xHEouZnS4daI5eJCOBv
dmjw1JUqryzH4xnlNsu5JjdFJt4TVlVu6mV1MvMesLp28XtpIUkWOPs9Oi7r
J7YuEpjnx96fBpv7UsU8H84UZtboumJAPC+atZ/usZco0P87NKdEJ49G32FJ
vPdg58B+zobxCajeNVZs6Y6tkRsoFfwrvPry32oN28xz4khq455n3In034aO
fP3r75wXS8T7Ezys8/ryKh45b8XB1rK61rQgzov7DmYkNE2tqsKoKBgTEcZ1
ykM65+luhX7+X0V82GU+5W1wxvW5P1D6K6f+IStC/ZtoPijl+dZofhjm+Z2k
D1hYH9YPFP1YX1D0Jb4full/B/kDLvaH6j1ALfvH/oLiL/sPiv/EC8Af7wfx
glDM+0O8ECj7xfsHF7x//5oHNGs=
          "]]}, "Charting`Private`Tag#208"], 
       Annotation[{
         Hue[0.7721393199562385, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx98minzMDRcku/SR5qspF+d1hQslRJFiIhEKyUdSEqMVNz42
K5KSmhJSby5OS6yFJUoJZY2Faaat1NLofc95z83T03me3znn/z8640Bdp0YQ
hBxBEOSTIohDw5q52OxUsUuJAP5Cwaw1qhWvLuX4xJKkvv78da1YrIQfG/S9
u63BFNFqkeMdwx0GfU1xski8N3Rm3rXrEhKZ50OT3bQzNR0vKrjLF3RPdq90
2OOY58Vx82jliSWGeR588vSEfloF5j1j1WD+TF5GBOj/Izqap6TyiRCsKe/v
0dG7er6c+AFU7w4PW9oMjSsPUKTwb7HJWHsmxR4B8a5xr+IorTDXjfTfheGF
0mpD+jPqlfenuOqKd2R9+zgv4XazyXYc9OOSct/Fg60yz2skgKqC0T85vnCT
8rDPebpLsMH/y4gPi8ynvAv8XJ/7A7W/Euof5rn/bpoPkOez0fxwwfNfkz7g
ZH1YP1D1Y31B1Zf4Xhhj/d3kD9ywP1TPB2b2j/0F1V/2H1T/ieeHet4P4n2C
gfeHeAGI8n7x/sEI798/VeUzoA==
          "]]}, "Charting`Private`Tag#209"], 
       Annotation[{
         Hue[0.008207297456067408, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx19SQmKFRLtwJV8RSz4uzrPJR65ErobytVYUucPFpNmdj3Kx
DUVKcsHdLjbqFEljNISE2ZoWbY0aRfLR3nPec/P0dJ7nd875/09B30j7YKIk
SUWSJMVPijfEJnut1aESBjmi6HUd3mgXVeLUE48IDhj3+vPKVKJKjjBaVhPX
N2YyxZI9Hi/YXNNVl6LLEMR7xqvZUbMjJZ15IfyKbas7R1OFjPM8oW7YM9Zh
SWZeEH0dnc/5PUnMC6Bfa9FtpiUwz496/eXFX/M30P97rFh3N06Nv4NNfn+L
vfXqLM1OGKjeNZp2Pj8mS31QKfMvcUKUl2gedoF4Xsyxzr3fdZ8g/XfjwLFN
H2h4xAr5/QEenTfdxrZDnHdi7n6haeIijAvyfQuLlrvbWmJRVBT8/YvHK65R
Hoo5T3cnZPP/GuKDi/mUd0Mr1+f+QOlPQ/3DPPdvpPlgmudboflhiOf3kj5Q
zfqwfqDox/qCoi/xgxBg/c/IHxDsD9ULwQ/7x/6C4i/7D4r/xAuDmfeDeBEw
8P4QLwqnvF+8f6Ds3z+KZzbb
          "]]}, "Charting`Private`Tag#210"], 
       Annotation[{
         Hue[0.24427527495583945`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8og3EYx1/LolbadlsUDjbiIKZceF5/CjloO8mfi6JF8mfmsIOLnFyk
1Pw5uEkOLprG5mlElo0VTSRN00zvbCspsUZ7n+d9Lr9+Pb/f53me7/epHJmy
jqoEQagRBCF/UmRwNuyrznXrxTE5UujwBx/9VXoxFMxHEn9bj6ySVyc2yiGh
qUNq0+p04sZ6Pt4xO6iZmTRqReIlsCjX3u9SlzAvjvNO8e94QCPKuOArfnZq
x8qHi5kXQ8zMW3bL1cx7QVWXlL13FzAvil7318XidBbo/xMamkKTFXNf4JLf
P6C9dMdx3/MBVC+Cd+OFvatDUWiQ+bf4VoeJ9JUfiBfGte5ly83mJdL/AI6e
Gqz7Q89YL78/Q/Pbodo3Eee8B32WpbK9AwlX5PsuTrRk4udSChUFc3/5SOM2
5cHGebp74IT/NxMfaplP+QD0cX3uD5T+zNQ/ZLl/G80HEZ5vi+aHBZ4/TPqA
ifVh/UDRj/UFRV/ix8DL+l+TP/DD/lC9ODjZP/YXFH/Zf1D8J54ERt4P4iXh
m/eHeCmw837x/sEc798/1bY8oQ==
          "]]}, "Charting`Private`Tag#211"], 
       Annotation[{
         Hue[0.4803432524556115, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kt8rg2EUx99WLkjGLmZuiFIsZTE1P+q8XEgkhaSsRO1HSky7kT+AcuOC
MJSryc8rKzKdpKkVmlYrbMsaa9p6hyI3G+095z03T0/neT7nnO/3VE/ODFpU
giDUC4KQPyk+cM9sdwtPGtEqh4QRb1VbzKMR727zkcav0I1k7dWIzXKkcDa5
VGFylYmuzXy8o2eh3X+0XyoSL4mHn+oiW7aEeQk8eNebRjuLRRl3+4r932uZ
OUMh8+KofejpKI8WMC+GF7mt5e5xFfNesM54o+1azQL9D2PtlyN5NvUDG/L7
R+w7/fWGoxJQvRBeDliu3DsxaJL5QdQ+Oz5HNn1AvADqFqema958SP/9GK8M
thjnI2iQ319jg9PmXdUnOH+OraNq5/B6Clfk+z6abSUnE68SKgrm/vKRwV3K
wxjn6X4OjfzfRHyoZT7l/RDi+twfKP0ZqX9o5P7tNB/4eL5tmh8sPH+A9AE9
68P6gaIf6wuKvsSPg471vyd/YIj9oXoJOGb/2F9Q/GX/QfGfeClQ9oN4afjg
/SGeBFHeL94/cPP+/QNDxTty
          "]]}, "Charting`Private`Tag#212"], 
       Annotation[{
         Hue[0.7164112299554404, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx98QudhkboQWccGWyFdyc96yRCKmlQu5UGOkltRaU5J2gRsr
lMmFjytFLTc+kiMu2HyWCE2ZMe9Mszslbdp7zntunp7O8/zOOf//KeqzGs0p
giCUCYKQPCliuH6WCJstOWK/HFG0Z2w6BxpzxMuLZHxhc6nh3HSnEavliKC1
1zjwUagRl9zJCGNFmVs/q8sWiSehS/vUcRTLYl4If3Gs5LpYJcq4izc8tO0H
fhOZzAtirrS1kOdOZ14Ap0f9g560VOa9oEFo6T7djgP992Nwvi1d6vmBRfn9
IxbpfZ7OuhhQvXv0HNvL/x5eoUrm36JxeCi/3eQF4t1g65wzRWo4QfrvxVr1
QZPP7cdK+f0Jqh2qtIXPd87voUs70jXpiKBLvm/gxO7UmvY5ioqC8UQyvnGF
8jDOebrvwQz/ryc+ZDCf8l4o5PrcHyj91VD/YOb+LTQf7PB8yzQ/6Hj+G9IH
JNaH9QNFP9YXFH2JH4QC1v+K/IEz9ofqhSDO/rG/oPjL/oPiP/EiMML7Qbwv
UPaHeFGw8X7x/sEq798/YIw0eg==
          "]]}, "Charting`Private`Tag#213"], 
       Annotation[{
         Hue[0.9524792074552124, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1klsow3EUx/94WDwIy+MeKIlSM3vw5PyU5pZreZDsQQ17oZbkwYvyJA9e
FEtuSUN5cSmKs7YHsVkLM5eVy2ZZY5Zb1DLtf87/vPz6dX6/zznn+z0FPYPt
pnRJkkokSUqdFHEcmPgs/v5Qi145Ypj1Gq7ReNTi1J2KF8wZXbKMdatFhRxR
3PYNd0ZW8oR1NhURbC7cz3i05QriPaPxtLRxeTCHeWGsP1DtHqVlCxnnDmFV
Sd24yZXFvCDay9/nzK0q5j3gsL5PXKxmMO8eLXZJu+xKAv0PoCZgvWpq+IEZ
+f01Tg4l7gy/caB6l1i7oFvPzw6BTuafo+GsQ3T9uYF4Xtz5cl6XzduR/h+j
/+mm4OTwFrXyeyeOBRNm/8YT5/fQloi0CWMUp+T7GjoCm1tJXwwVBf+SqXjD
RcqDk/N034NF/l9JfBhhPuWPwcH1uT9Q+tNT/2Dh/vtpPmjk+eZofpjm+b2k
DxSxPqwfKPqxvqDoS/wgOFl/D/kD1ewP1QtDC/vH/oLiL/sPiv/Ei8Iu7wfx
XkDZH+LFIJP3i/cPzLx//5bGRFo=
          "]]}, "Charting`Private`Tag#214"], 
       Annotation[{
         Hue[0.18854718495498446`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx5+G5mNtmOxSQ0q58LELSs6bciE3UnJJ1pgbCheSciUfuZAr
k8SdpSiEaXViJctsK5Gt5Ws2H9PMhZkbtPec99w8PZ3n+Z1z/v9j7B3qsKiE
EJVCiPRJkUBNR3BjfKJI6pMjjpaAy+DpLJIuPOl4R0/yeWLvUS/VyRFDu91Z
lluhl5Zt6XhF3ezdwUh5oUS8F5zBBl3bUz7zorhVYLK9BbWSjPM8YbfJuN+7
mMe8MCZu1CpnRjbzHrBnJ1MMt2Qy7x4ntW1YMyT4fwgf9Oau+dofWJLfB7DU
cbUpDj+B6l1jMmTwjTVGoFbmX6Jmu/12qtUPxPNj/lnxcarEifTfjcsDgdW5
lyBWy+9dqO1vSo0ORjjvwO/To3NbcwwX5Lsd163GE7UvjoqCv3/p+MA1ysMq
5+nugC/+X098yGI+5d0wzfW5P1D6M1H/UMD9W2k+SPF8KzQ/VPH8ftIH3lgf
1g8U/VhfUPQlfhiSrL+X/AEz+0P1orDL/rG/oPjL/oPiP/FisMn7Qbx38PL+
EC8OZt4v3j/I4f37B8ISNK0=
          "]]}, "Charting`Private`Tag#215"], 
       Annotation[{
         Hue[0.42461516245481334`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kt8rg2EUx18/YknEtlZyg7JE0ssFJee9kOFGSbiU+XWhlH/AJHLpSmjW
ynaxhgs3WK1Du0BGi1Jb2Pxa9K5NyoUxtPec59w8PZ3n+Zxzvt9TNTrTP54r
SVKdJEnZk+Id41tfUX+OUZnQIokn5ppAR8SgXASzkcAu37HbN2ZQmrVQsbvw
3mBy6ZWN9Wy84aJ3yq/fLFeI94qN5r/VhsEy5sWxMx0dftwtVTRc8BnlTEWJ
a6CYeU842VOUd76nY94DRuy2795YPvNi6Jg+6Or7lPj/LVa6Q0sWYxrWtPdh
zNT/LDTPfgDVu8HgUXtsxxoHWeNf45zbY0vrroB4IVQj1vnt6n2k/2eYkmF3
xBTBJu19AK3R2/ol+YXzh+i2eO/WzSquaHcPPvg9jrbTJAoFf/+ykUIn5UHk
6X4ITv7fSnwYYj7lzyDM9bk/EP21UP+wzP1P0Xwg5rPT/FDQQPOHSB+oZX1Y
PxD6sb4g9CX+Ewj9L8kfaGd/qF4cutk/9heEv+w/CP+Jp4LYD+IlwML7Q7wk
iP3i/QOxf/+H6zvx
          "]]}, "Charting`Private`Tag#216"], 
       Annotation[{
         Hue[0.6606831399545854, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx19ETa18bLUQWUkuyGdWsvO64eJ1wyWNJZYLcrkLpdaUxIWP
1HxlJatlKK5W6viIUiOlFAkz5uPVyEdEM+095z03T0/neX7nnP//5Hf0NXcl
CoJQJAhC/KR4xZKbZseIUy/alIhgbfaGVNeqFw8D8XjGKstn0BrSiRVKyDg6
ZFm+zNWJM9PxeMTJwI5vIiNTJN4D9vtyDVl76cwLo8O9vrViThMVXOAWPZ1J
vxfpWuaFsD0mDDdZNMwLovXqSzDak5l3jYM1OfMf9gT+f4Eel3u24O0HXMr7
M1xM8S1NFb4D1TvFv6fqKDjvoVzhn2DjRMv4+eYJEO8Y74oHPvvq15H+H2De
vtW0IJ1hqfJ+F6tebbLx+5bzfoz1eK2SVsYx5e5FqdegcW1HUFUwGovHC7op
Dw2cp7sf/vi/ifhQzHzKH0Aq1+f+QO2vkvqHNu6/m+aDGM83R/PDGs9/TPqA
qg/rB6p+rC+o+hI/BF2s/xH5A6vsD9ULwyD7x/6C6i/7D6r/xJNhjPeDeM9Q
zftDvAiYeb94/6CM9+8fjb026w==
          "]]}, "Charting`Private`Tag#217"], 
       Annotation[{
         Hue[0.8967511174543574, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kksoRGEUxy9Kmcb7mYVnFqzGoyhybmFhg7AYlDIhC+URi0lWyG6aqPFI
HimZLJiFIk2nxmZGd8aUvEIe420MNfJIE809557N19f5vt855/8/mbqe+o5Q
QRByBUEInhTvaKxTT22EJImdcviwYq5MtXSSKDqlYHhRO147MNiaKBbK8YKG
C8msMSWIszPBeMLsIXejbTReJN4jNi/svT5o4ph3jxN9DW2hyzGijJNuMbrY
fmNzRDLPg8LIWYU6TMW8a/zo1ffvRIQz7wq1zukY32cI/z9H3dBq2r79F6bl
96cYVW0puTz2A9U7wvn07xrr7CMUyPwDNFdKFn37IRDPjV+6clVr6hrSfwc2
6WMDprET1Mjvd7HUah7W4S3ntzHgGrnb8j+jUb6bMWs8bz1nx4eKgoG/YLzh
IuUhg/N034Yf/l9CfMhnPuUdIHJ97g+U/oqof9jk/rtoPljh+eZofkjm+d2k
D3SzPqwfKPqxvqDoS3wPKPq7yB9IYX+o3j1Msn/sLyj+sv+g+E+8FzDyfhDP
Cy28P8TzQRXvF+8fGHj//gEseTg6
          "]]}, "Charting`Private`Tag#218"], 
       Annotation[{
         Hue[0.1328190949541863, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx1+S8m3T3CsuhiJfKRfnFSV3Uq7ExcS0XayEixFy5UY0+Zjk
Ize4QRFzc2itDNMiEyEyYx+NtYVC0/ue856bp6fzPL9zzv9/8nSm5s5EQRC0
giBIJ8UHZm7Xz/wM5IpdcoRRZWg5LG7OFV1nUoSwbiKWcHylEcvlCGLkaLjw
IUUjzlul8ONGst3VF80RifeGy+7xDaNVzTwfqocsYw1JKlHGnXnR9L0vZgxm
Mu8ZSzaXHLbVVOY9YfpFtO1+Npl5j1ijr+pI6Unk/3fYdNCZ9T73C3Py+xsM
TC4aT0ZjQPU8uPppqNhb90OZzL/E3a/h9tK4B4jnxlOL1jwRWUH678T4a0Hv
jOMaS+X3dqzsWhtpHfNy3oaG/KOt0G0AJ+X7Ok439he97IRRUfAvLsU7LlMe
pjhPdxvo+X818aGI+ZR3QoDrc3+g9FdB/YOD+++m+WCT51ug+eGT53eTPqBj
fVg/UPRjfUHRl/jPUMz6n5M/YGZ/qJ4PNOwf+wuKv+w/KP4TLwgx3g/ihaCW
94d4Ycjm/eL9gzTev38flj9D
          "]]}, "Charting`Private`Tag#219"], 
       Annotation[{
         Hue[0.36888707245395835`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx9/ko7WV7124W0oWabGkqPNeiGi1UC4ktJAbSSgiJS4wRZKv
XEhZKU1J9F6dvLuQmGQYGY2NDM0oF/LZ3nPec/P0dJ7nd875/4/B1lHdEiMI
glEQhOhJEUFPXmlXybtebFUijN3Dnetbe3rRfRiNF7Ro0hzGCr1YoMQzXlSt
bkp96eLiQjRCmORosg81pInEe8Ryzbhx4DeFeQ/oGYgP1NqSRQV3GESn7kru
yU5kXgAtRtdSBmiZd4tl3rYZqyGBeX4s7ri+SQ/F8H8f3tfZ4wpsPzCvvL/E
r93CydTsD6B65zj6edcubzxBvsL3oDnny1Q/cQHEO0bTYLMlK3ca6f8+7sCp
M6T1okl578KxoMefWRPkvITjhbPbEfkJp5T7Gh7MN8ZeOsOoKvj9F41XXKY8
uDlPdwlG+H8R8aGf+ZTfhxWuz/2B2p+Z+odK7r+N5oM5nm+J5gedTPMfkz7w
xvqwfqDqx/qCqi/xA2Bl/Y/IH5DYH6r3AGfsH/sLqr/sP6j+E+8ZfLwfxHsB
dX+IF4Ze3i/ePzjh/fsH2SEy3w==
          "]]}, "Charting`Private`Tag#220"], 
       Annotation[{
         Hue[0.6049550499537304, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8ow2EYx38ZKSta2G5biklz8O9gp+d3WBE5zEHKYSzEYeSE6xKODjJk
2UX8wmEHIemRpbXM+hXN3wMZYWvmoJQ/037P8z6Xt7fnfT/P83y/T4V7tHMg
T5KkGkmScidFBn/dBTuOfpM8qEUaM4EOf5HdJJ9Fc5HCeNtXvmfPKDdqkcQJ
67HD91QuLy/l4hVn0sGRg5MymXgvaKu2rn64Spn3jNEZs0t/aJA1XDSBfkvr
4F6shHmP6A1veD4u9Mx7wPXGvqPbtULm3eOwe3so0aPj/3c4e+91tlf+waL2
/hp9Xdm6yfAnUL04FplrW8a3ktCg8c+x3hi09OpvgHgq2qpOr2weJ9L/CIYc
WftNdxzrtPchLFanVdWS4Pw+Tlx+L8Q233BOuysYUco2dUoahYI/2Vy8Y4Dy
EOY83fdhjP83Ex90zKd8BHa5PvcHor8m6h/s3P8QzQcGnm+F5geF51dJH5hn
fVg/EPqxviD0Jf4jTLH+MfIHFPaH6j3DGfvH/oLwl/0H4T/xkiD2g3gpuOT9
IV4axH7x/oHYv38hiDdl
          "]]}, "Charting`Private`Tag#221"], 
       Annotation[{
         Hue[0.8410230274535024, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1klsow3EUx/9GyDzMdUqRRLy5LBNy/gpLoVwelJKUS3kQD0sWkcSLS61l
k6JcilaeqIWOUjKhSUgka5rL5u/yIMmt/c/5n5dfv87v9znnfL8npaWrtlUl
CEKmIAiBk+IVUxs1Y/cnWrFNDgnV6/YQ1bJWPDoMhB83vjub2lK1Yq4cPnwe
GOmprIoXZ2yBeMSh8qiLr4w4kXgPOCqlryxtxzDPi5b3hKKS2GhRxh3eobnG
4KzQa5jnwa/xAnVwayTz3OhKtpmq0sKZd4vuwVWz4SCY/1/jb95Zou/mF6zy
+0tsaHzTbTV/ANU7x2pV8U73nB9yZP4pGi2uzUXTFRDPhabSwqQ8+wT/d2KE
qTdozX6GWfL7XTwx7qNR8iDlHThU77VNWp5wSr6voL7M3Ne+IKGi4PdfIF5w
nvKQzXm6O6Cf/+cTH/aYT3knfPZRfe4PlP501D8Mc/8dNB/U8XyzND+08Pwu
0gdC9aQP6weKfqwvKPoS3wM/rP8x+QPT7A/V84KV/WN/QfGX/QfFf+L54JX3
g3h+UPaHeBKE8X7x/kEK798/z9syGg==
          "]]}, "Charting`Private`Tag#222"], 
       Annotation[{
         Hue[0.07709100495333132, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl8oQ3EUx29aQ6HF2FKShz1QSixJ6lwPisfZvHjwMPmTaLIXxYMaxYt4
kJFcXkT2sGZhpY6STKEhk1r+dNfCZhNSoqbdc+55+fXr/H6fc873eyrsjvae
LEEQKgVByJwU79ixuR76aTSKvUokcWLKnjtcYBTPzzKRwPwvhxSfMYh1SsQx
8PY55PWWiMtLmXhBh37RZ5wuFon3jB+e6i6nQc+8GB4fDhjDfYWigjuLYm25
tjTq0jFPRn/MPVuSymPeE7qcD90jUg7zHnG/7MBXZNbw/wi2Lgy7gvNpcCvv
71C2QFL6/AaqF8bgxZjfMv0GtQr/Gnea7wfdkQgQL4S/G7LOpJf4/yleDrSY
Pdk3WKO8P0Kru9NWiTJSPoBVV9J208Qrzin3LRzX7O1qV5OoKviXzkQK1ygP
o5ynewBM/L+B+NDGfMqfAnJ97g/U/szUP5xw//00H9zyfCs0PyR4/hDpAzbW
h/UDVT/WF1R9iS+Dqv8F+QP17A/Vi0GQ/WN/QfWX/QfVf+LFQd0P4iUgj/eH
eEmY5P3i/QMr798/0qk4pw==
          "]]}, "Charting`Private`Tag#223"], 
       Annotation[{
         Hue[0.31315898245310336`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl8oQ3EUx294UYaYNnsQL6uRPyFT1LlP3kieCMWK/GmpefIk3hCNhVlb
eBDzorxoUUd5Wm1aiMQWrsY23YlGkqbdc+55+fXr/H6fc873eyosE11DWYIg
mARByJwU76jf1rV2berFYSVkDDl2nFU2vRgMZOINA96WyauETmxQIoER/VOp
u0AnujYyEcPBmfBi8qlEJN4rzofX+8xWLfOi2N3uSO8dFYkKLvCM5XmeeF6w
kHkSfp3eWFM2DfMecdReXmvQ5jLvAd1LqVjZRg7/v8c+GOjvKBNEp/L+Fj1T
RnN8+huo3jWeVNqE42EZ6hX+Je7UZO8fVEeAeCH80chNc/m7QP/9mJ79NBWP
XWGd8v4MH7+1lt9lCSnvQ9dHW09kPI525e7F1ZfOBckpo6rgbzoTSdyiPKxx
nu4+WOH/zcSHO+ZT3g8Jrs/9gdpfI/UPh9z/CM0Hfp7PTfPDHs8fIn1ggPVh
/UDVj/UFVV/iS/DH+p+TP2Bkf6heFHrZP/YXVH/Zf1D9J14CJN4P4r2Bn/eH
eDJc8H7x/oGB9+8fanE2wQ==
          "]]}, "Charting`Private`Tag#224"], 
       Annotation[{
         Hue[0.5492269599528754, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8ow2EYx3+xHcQOQ9u4yJx2kz+Fmue3VpojErWiaIuUJcLByQ6uJoSE
KHJRDg6oPTV/p80mElKbTQubbXLwr9B+z/N7Lm9vz/t+nuf5fp/SLkezLUsQ
BIMgCJmTIo15hpUm769OtEuRxPft1WHVhU70+zKRwDf/eMu3RSdWShHHkvq9
opderbgwn4lnjBxp1qy1GpF4T5jW7t8E3IXMi6H5tG1kIbtAlHC+Rww7B6wb
+WrmRdHc4XH1pVXMe8AT16xb48xhXhhnAmVg+lLw/3tUrB2rpxyCOCe9v8W9
Rs9Et/ITqN41Bs2K9da6FFRI/Ev07XyV2/pDQLwgxoyFH6PVW0D/vTi0rGzU
X11iufT+AN/vXNFfexQpv4tHxYP+sfYXnJTum2hasuQK00mUFfz5y0QKVygP
Rs7TfRcO+X8N8eGV+ZT3QifX5/5A7q+K+oc77r+H5oMQz7dI88MZzx8kfSCX
9WH9QNaP9QVZX+JHwcL6n5M/EGF/qF4MGtg/9hdkf9l/kP0nXhz0vB/ES0Ca
94d4SZD3i/cPVLx//0YaNdg=
          "]]}, "Charting`Private`Tag#225"], 
       Annotation[{
         Hue[0.7852949374527043, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kksohFEUxz8KiUjjNTKJhTzKezE0OZ8SyTOmJCUNPrKRjdR4FMmCYjdm
GmLJjrIgOiFpakhNmQaL0Uge02dqlNeC5jvnns3tdu79nXP+/5NrGescipYk
qVCSpMhJEcL86dy56h69rGihYvtlS1uoSC9fuiMRROvGj824lSlXavGGrV2L
/gnMkB32SLzgftb4c81Suky8Z1R2J3eyE9OY94QZTZbl5WadrOHcj+hR18M2
cwrzAti/vzHaOJzEvAeM7c4sNwXjmefHYp1j22yO4f/3+D3grlo5kuQ17b0P
e02+BO/8F1C9G8w7mfpUokJQofE9eNhaZzC0+4F41/iafJoaN7MH9N+FH8cL
amqDB8u092e4NVISrq8NIOUP8N75585peMVV7b6Ns3cXpX0rKgoFf/8i8Y6b
lAcr5+l+AF7+byQ+2JlPeRf4uT73B6K/Kuofzrn/EZoP8nk+J80PCs9/TfpA
1CDpw/qB0I/1BaEv8QOgsP5X5A/csj9U7wmEf+wvCH/ZfxD+E+8NOng/iBcE
sT/EU0HsF+8fFPD+/QPqByx3
          "]]}, "Charting`Private`Tag#226"], 
       Annotation[{
         Hue[0.02136291495247633, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kksohFEUxz80FhbyCDMLZSKPnTCN3bkrOylN0lh4RRbEktVEFDYjK4YF
JTWmEEmzmM6UQWoGUYzi8/gk8zAzCyGD0XznfGdzu517f+ec//8Ye4Zb+zIl
SaqRJCl9UiTwY6/dbNs0iH41Yph09nq3bQYR8KcjikdBw9Tgu17UqxHBn2OB
ZXl64VhMRwjr7QelQ8FiQbxXfFqqsKYsRcx7Qb9FyD32QqHi/M/Ya4i4fPP5
zFPwbTKUZb3OZd4jyjXj710tOcx7QM+q2Wja0PH/W9wxfTZX6TLEgvr+Bkf7
HfsFyS+gelcYLIg3hTsTUKfyL3HstbKtQ34A4p1jdbFpLbC1B/T/BL1RX1u5
9wJr1fcHuOnp9t2VKEh5Nyqpv93ThjDOqXcnTmePXKdmY6gpmEylI44rlIdJ
ztPdDTL/byQ+rDOf8ifg4vrcH2j9NVD/MMH9D9B8cM/zLdP8MMPzn5M+sM/6
sH6g6cf6gqYv8RWIs/6n5A/0sT9U7wXO2D/2FzR/2X/Q/CdeBH55P4gXhUPe
H+LF4Jv3i/cPvnj//gHfC0CB
          "]]}, "Charting`Private`Tag#227"], 
       Annotation[{
         Hue[0.25743089245224837`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx19fNy5Iplm5oFwgK20rbnTetis3LnajLJRYUiZK3CyhcSHs
Qs0W+cgNLVfUFnUUYhkWNVu58Dlfaz6WaVNo7znvuXl6Os/zO+f8/6esvdfY
mSkIQqUgCOmT4h3HHipuh35VolmKGDqs7j71mUo88acjil+Nec0DepWoleIV
P0qMn4emYtHlTMczanTD4YtSpUi8J7TVblebnEXMi2BbeGc986xQlHD+e8zX
aJOKkwLm3eGxOVs5KOYz7wYnE1XBFncu867RsLjs3k3l8P8rRItlpb4hQ5yT
3ofxyGswPXYngeoFMR6cbZ3xvING4l+gbbJsdbPjBogXQHX5bsq/4QH670Pr
j3FiVH+ONdL7Pcwy9yyE4rdIeS82TV/228tf0C7d19DjcB1ExmMoK5j6S8cb
LlEetjhPdy8Y+X8d8eG7k/iU94GZ63N/IPeno/5hivvvovngh+ebp/khxPMH
SB/YZ31YP5D1Y31B1pf4dxBg/U/JH1CwP1QvArJ/7C/I/rL/IPtPvFeQ94N4
UUjw/hAvBk7eL94/GOH9+we9bzyu
          "]]}, "Charting`Private`Tag#228"], 
       Annotation[{
         Hue[0.49349886995207726`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx19WiKKWNZaSK+zCtC0ZF+ct+UqRuZALFxhh8nHhgluJzIWv
C+Q7xSh3kqhzwYUJGzImymwtH2uMG6Ro7znvuXl6Os/zO+f8/yejscvcHC0I
QrYgCJGT4h3bw6q42HKN2CJFCDcmalNKUzXi6UkkgrjQ5Ks32lJFgxSvqN6v
26pcSRFnZyLxjIeFD1Nmi1ok3hPqvhp0Ko+KeQG0Ho/fmOOTRQl34kelR+vu
USiZ58PMPmda70oS87yoL+9VJioSmPeA/UObndfFMfz/DkfzysSd4ShxWnrv
QafRvp11+Q1Uz43F1VU5hoQw6CX+Jd76bcFPrxeI50Jnes3vVd8e0H8Hmj7y
Ciyn55grvT/A9aO286KLR6T8LppKRmxW1QuOSXc7DnasLicPhFBW8OcvEm+4
RHkY4Dzdd0HP//OJD/PMp7wDtFyf+wO5PyP1D37uv5Xmgwqeb47mh3ue30X6
wCTrw/qBrB/rC7K+xPeBlvU/I39Azf5QvQB0s3/sL8j+sv8g+0+8V5D3g3hB
WOT9IV4I1ni/eP/Ayvv3D1PSKt4=
          "]]}, "Charting`Private`Tag#229"], 
       Annotation[{
         Hue[0.7295668474518493, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx18uJqFJy9iFomRqJBu5UOclN66UGSISkfJd7pa40cRaEoVc
yJ0LwtLakpNExiwipVzgZcbWfCaJaO8577l5ejrP8zvn/P8ns7Wvuj1WEIRc
QRCiJ8ULTtoCVYkOndghRwTNDY6x6yadeOyLRhgPguchuz9dNMoRwjunzjAn
pYnzc9F4xB+pweVf0orEC+L0W365RpPKvABuuXpiSss0oozz3eGHZPftFaUw
T8Icq74571fNvBs8spnbqswJzLvGyoHHjcYJFf+/woz1rHjrbow4K7+/xPf1
mdEV4zdQvQv0/HWpNuteoVDmn+GgNnn1wXILxDvB4qFarV+9DfTfiyNH/Yef
LadYIL/fxfTImsfgvEXKu3HAlK3uiHvCSfm+jDX1FZ/jwxFUFPz+i8YzLlIe
LJynuxu6+X8J8SGJ+ZT3Qi/X5/5A6c9E/cMw999J88EOz7dA84OwQfOfkD6g
Z31YP1D0Y31B0Zf4EmSz/n7yB77YH6oXgG32j/0FxV/2HxT/iReCe94P4oVh
n/eHeBGo4f3i/YMp3r9/G4o0hA==
          "]]}, "Charting`Private`Tag#230"], 
       Annotation[{
         Hue[0.9656348249516213, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx9+tKPlIGrILi1rhxsc0SjmvS1woV3bhZgwXPpJyY8mNO0op
GVs+2sq4lLKis1LysWmlfA2xydfmNTfYMrT3nPfcPD2d5/mdc/7/U2Ieareo
BUEoFwQhdVLEMOzrmx7wa8UeOSS8mNV7b+1a0e9LRRQ7dEfj3Vla0SBHBNeN
js1pXZG4YEvFC0oN4krldaFIvGfctRlKm1oKmPeI1qfmsbURjSjjfA+odbmS
P115zAvj1b5T1ViWy7x7nKy4yVY7Mpl3hxmDvfHq43T+f40H+Wk7w3GVOC+/
v8SZ0V9b21QCqN4ZRlatzk/HB9TI/FOUgnqN2RsC4gUwpz95eV7nBfp/iJou
X4klGcAq+f0efoXcW0tzIaS8BzuN5sXJxAvOyHc3bte+VbVaJVQUTPyl4h2X
KQ9bnKe7B0z8v5748Mp8yh/Cj5nqc3+g9FdL/cM3999H80GM57PT/ODg+QOk
D5ywPqwfKPqxvqDoS/wwBFn/E/IHitkfqvcIE+wf+wuKv+w/KP4TLwIbvB/E
i4KJ94d4Eij7xfsHyv79AxBvPCo=
          "]]}, "Charting`Private`Tag#231"], 
       Annotation[{
         Hue[0.20170280245145022`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx19jzTbaJg1bLe5YifkoHxfnVdyxC0Wu1BTJzUTS4kaNS9z5
SGILk3KhJLk4SZIaJpkwNZsWbV6UFBdo7znvuXl6Os/zO+f8/6ekx93eqxIE
oUwQhPRJ8Y7TWx1Bk8Yq9skhoW/E/VEatohnwXSkUH/zeeBrtojVciRx4Nez
nt9ZJC4upOMFXw1zu93GQpF4z6iuOBmaGjMzL4HLO7ku72q+KOOCT1i+12BX
T+cxL47XhgxTsdPIvEcMZN1L2VE986Ko9U9kNKk1/D+C/VHv76RdJc7L72/x
05z5mIz8ANULo3+0ESIPH1Al868w5rJp60viQLwQ2hz+tpbWQ6D/p+gUcgNh
Xwgr5fdHGL38sgbGY0j5fTzWDXddSC84K983MWe7cbXTI6Gi4PdfOt5whfKg
5zzd90H5X0d8uGI+5U+hlutzf6D0V0P9Q4r776f5YIPnW6L5QV1A84dIHxhk
fVg/UPRjfUHRl/hxuGP9z8kfcLA/VC8BPvaP/QXFX/YfFP+JlwQ37wfxUqDj
/SGeBGu8X7x/MMP79w/Vayld
          "]]}, "Charting`Private`Tag#232"], 
       Annotation[{
         Hue[0.43777077995122227`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8ow2EYx3+t1gglabZxETuYFOaAy/M7iNSIHRTHaXLbHMwOyoFotBon
5KCl/Dm4rLTJempE02ha0RqFITNmrZB2oP2e5/dc3t6e9/08z/P9PrUWm9mq
EAShQRCEwkmRxcRH/8hjZ7U4JkUGd0oM7p3iavEiUoh31H95plumdKJRijRu
/ppcmgWtuL5WiBTeufSjPaARifeKy96y0+i2mnkv6NdOrwfPK0UJF3lC9Uwk
cOGrYF4S5yYtz032cuY9YL2yb763ppR595guiscmOlT8/xbNK43WrSGFuCq9
j+PJkW/Sos8D1btG74Nj2VSVg1aJH8O384PubmcSiBdFlTdhCHWFgP6HMWd2
Gm2DUWyW3h+j+0wlDlgfkfIBPFzMf/c8pdAj3XdxSWl37jsyKCv481eIT9yk
PCxynu4B8PP/duLDLPMpH4Ybrs/9gdxfG/UPWe5/nOaDXZ5vg+aHK54/SvrA
MOvD+oGsH+sLsr7ET4KL9b8kf0DH/lC9Fwiyf+wvyP6y/yD7T7w0bPF+EO8d
6nh/iJeBPd4v3j+45f37BxiEMok=
          "]]}, "Charting`Private`Tag#233"], 
       Annotation[{
         Hue[0.6738387574509943, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kl0og2EUx19qiUZCMkoUyYiFYm7OWy40k8+WckeN15XEndzuhuRKCBEX
PtYIJSmHlhizTTKRC2wta2vzeeMj2nvOe26ens7z/M45///J7+5vM8cLglAs
CELspHhB+/yH+0zKEXvkiOCowWI0VOeIF85YhLHz9dD7s5QtVsoRwsawUW3Z
0ogz07EIose0UnojZYnEe0bV0+5yijuTeQEcsEu+umiGKOOcfsx1lR3VX6cx
z4dlhXVJneOpzHvE5HJ/nLVVzbwH9Ku7zjd6E/j/Pa4faIb3R+LFKfn9LZZ0
TFknzd9A9by4rRX8uoY3qJD5V1hk05p7j31APA/Oba+J4Tw70H8HmopPvpoS
PaiT39txIJTet9jyhJTfw4LLWtv7XRAn5Psqqn7fT9uHIqgo+PkXiyguUB7i
OE/3Pcjl/zXEB4n5lHeAnutzf6D0V0X9g477l2g+2OH5Zml+0PP8HtIHNlkf
1g8U/VhfUPQlvg/KWX8X+QN57A/VC8Ag+8f+guIv+w+K/8QLQTPvB/HCoOwP
8SIwxvvF+wfK/v0DxOc1fA==
          "]]}, "Charting`Private`Tag#234"], 
       Annotation[{
         Hue[0.9099067349508232, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8ow2EYx39NsYP8WRFWatjkNuwgB8/v4E/JydFhIdaSWik7KCVRDqsp
FNoadvDnpHYah0d2wNpsDYtyGBZbbNiiRov2e57fc3l7e9738zzP9/toRi2D
4wpBEFoEQSicFB+YtpbVepfVokmKNPod3YacUS0GA4V4w3DTgjbrrxPbpXjF
7VxeNXBbK25uFCKJFSOGw7ytRiReApeuf1b1n9XMe0ZbpDWiLK8SJVwgjpoe
q9KUUTHvCR39npX1vQrmPeDNy2Sveq6UeTEccM87E/YS/n+PZ+b4+bFLIa5L
7+9w4ihbb3H+AtWLosa4UT1tzUCbxL9Cz8FJYlYZB+KFcce3ZJ+M+YD+X2BD
c1Gldi2Eeum9D4PBmZC76xEp78Xh4rHOaCSJy9J9Hx3q1GLfVBplBb/+CvGO
W5QHOU93Lwzx/w7iwynzKX8B3zqqz/2B3J+B+gcv92+m+UDH8zlofpjh+cOk
D4RZH9YPZP1YX5D1Jf4TuFj/S/IHGtkfqvcMdvaP/QXZX/YfZP+J9wq7vB/E
e4NL3h/ipSHA+8X7Bynev3+fUDpC
          "]]}, "Charting`Private`Tag#235"], 
       Annotation[{
         Hue[0.14597471245059523`, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kt0rw2EUx38puSDm3SxFCnNDXmoX6vz2B1AkN8pbkUK0CykuJKHdEBcz
pkRiXhK5mbcjpNgwZMW8W7KskZTFBe13znNunp7O83zOOd/vSatrLasPkSRJ
K0lS8KT4QGPLQefEqkZuUMKPd8memblujXzsCIYPO+L2o0J9yXK+Em+4VRG9
URlQy2PmYHhxanhnaXEhSSbeK673r6dqIxOZ94J9+q7bP228rOAcHjwr16lS
wmOZ94yGkpj0+20V8x6xUJ0R6J2NYN4Djq+U1kashvH/G3SFzl+bNkPkUeX9
FSYUbK9dOn6B6rlwevluNszyCXkK/wKPrPbiVr0HiOfEn2Zr03fPPtD/QxzJ
MFXPZJ9irvJ+D3f1g+aqnCekvA3rDZnuT7sXh5S7FYva3T3GNj8KBb/+gvGO
k5QHkae7Dar5v474sMl8yh9CDdfn/kD0V0D9g5P7b6T5YJ7ns9D8kMXzO0kf
uGF9WD8Q+rG+IPQl/jMI/U/IHzhnf6jeCxjZP/YXhL/sPwj/ifcGO7wfxPOB
2B/i+UHsF+8fDPD+/QOgSDey
          "]]}, "Charting`Private`Tag#236"], 
       Annotation[{
         Hue[0.3820426899503673, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kktIQlEQhi9CZGAPkiyyB0VCRYtei4hg7sIWhbUoKMKEMhKJoCBoU6uC
NkG0CcokbFeLNhGEEY1kL8HsYQ8NF2mhiWIPly0K78ydzeEw53wz8/9TZZ7q
G1cIglAnCELmpPjC0NP31oRPK1qkSKHJGTZ227XitTcTSdxuml3RZWvFFikS
uHhgMO8Uloq2jUzEcVn3qAqclYjE+8D2wdhLUlfMvCie7jeOVohFooTzvqM1
rdWMVaqZ94ZF1vpEzV0B88IoKBULwUsV814xJ+9+LdeXzf9DeOUa7tQ/KMR1
6X0QGzb79w7Tv0D1ntCorz0OHv1As8T341BemVo3/Q7Eu8XKfK/NoDwH+u/B
mKsnq8vvw0bpvRsj+deB5+oIUt6JA5bJPsNFHFel+y7OV3XOlE+lUFYw/ZeJ
T3RQHuY4T3cn9PL/NuLDM/Mp74ETrs/9gdxfK/UPJu7fSvPBCM9np/mhg+e/
JX3ghvVh/UDWj/UFWV/iv4GG9feRP2Bhf6heFNzsH/sLsr/sP8j+Ey8BS7wf
xEuCg/eHeCkw8n7x/kGA9+8fzMIpqg==
          "]]}, "Charting`Private`Tag#237"], 
       Annotation[{
         Hue[0.6181106674501393, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kktIQlEQhi9BtMhF9KDHbVG4kFaFBRpEczcKLnPRRiqS3tBLqoVroajA
yMCSiGoRhLWIoBCCIaNFUFoJUWCYXdFSs9eiTVB4Z+5sDoc555uZ/596+7i1
v0AQhAZBEPInxQeawwPuioQoDSiRQ5O1cCpyIEpXl/nIovgY/rTUilKzEhn0
tPv8Ol2N5FvLxysu+Lrj0/dVEvFe0F5X3OcwVjIvia7U0bato0JScJcJnOwK
VDU1ljFPxt6/vUN7rIR5cezUhURNXMO8J5zat+jichH/j+LJG/iPkwXSqvL+
AWcGb3YKS3+B6t1h60avNnb7BXqFH8H0fjS4uJIA4l1jj2F+1DBxDvT/ArUj
No/eHcIm5f0Zuracs+XVz0j5AHqdbXLi9BWXlPsupkbH0sJYDlUFv//y8Y6b
lAeZ83QPwDL/NxIfnMyn/AX8DFN97g/U/lqof8hy/0M0HwDPt07zg4vnvyZ9
IMj6sH6g6sf6gqov8WWws/4h8gcc7A/VS8Ic+8f+guov+w+q/8TLgJf3g3hZ
qOH9IV4OzLxfvH9g4v37BznxNGo=
          "]]}, "Charting`Private`Tag#238"], 
       Annotation[{
         Hue[0.8541786449499682, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw1kk8ow2EYx3+NIjHamLGDdhJSGit/Ds/v4uaw5IYdFHGw1RxccCFK0iL/
hiy5KEkcRPEkJMVMllhTm83aZo02ByS03/P8nsvb2/O+n+d5vt9H32Vt7VYI
glAhCEL6pHhHdVbH2VxKJ/ZIkUDN1KGt6UQnXl+lI47O68mXviqdWCvFKx6Z
K0dvjaWiYykdUaweW7eOhLUi8SJoesq07DYXMy+MyTaLZ6ezSJRwVyHcGrzw
DjeqmRfEyKzSNxMtYF4AXfNwo0rlMs+Pxo/VgZFUFv/3YUZsHmMphbgovX/E
X79+Y6/8B6jePRraPJ3KUBIMEv8OlfkPXwvbISCeG72BEs/04TnQ/0tcTsx+
D5ldWCO9P0W7Y39cq3pGyh/g6ZTfdHwcRbt030RTTlm7sT+BsoLJv3S8oZPy
0MJ5uh/AEf+vJz5MMJ/yl2Dj+twfyP3VUf+g4f57aT5o4PlWaH7IC9D8btIH
slkf1g9k/VhfkPUlfhDirL+L/IFt9ofqheGT/WN/QfaX/QfZf+K9AvJ+EC8O
a7w/xEuAlveL9w8Kef/+ASb6PhA=
          "]]}, "Charting`Private`Tag#239"], 
       Annotation[{
         Hue[0.09024662244974024, 0.6, 0.6], 
         Directive[
          PointSize[
           Rational[1, 360]], 
          AbsoluteThickness[2], 
          Opacity[0.4], 
          RGBColor[0, 0, 1]], 
         Line[CompressedData["
1:eJw9kl0og2EUx1+7cYEiZLYrljIlmtGKnNfNRC0lF0oiIcnHhd1tZUW5QImU
jxXlYik3uxzaSZrQLCIfJR/7Ym29w4WSifae8zo3T0/neX7nnP//lPSNtw+o
BEHQC4KQPineELouSiMprTgoh4TlBVaz/VQrnvnTkUBnm8k6adSKNXLE0Xe0
U7LZqBHXVtMRQxE7qhKSWiTeKy5b3r0uSxHzori+1KcuHigUZZw/jHWu5Uhz
Uz7zQlisOeh2J3OZ94zm/qAt+pPNvCcss+9aHlOZ/P8ehz+nWm6/VeKK/P4O
db/uPI8xBVTvGucrwxu90gcYZP4lzmXpRhu8YSDeOUKnbaz2xQf0/wRnMm4c
9U0BrJbfH+JsxZczmhNEyntw+qrq4W4/hgvyfRtbddaivREJ/xX8TUcSNykP
Zs7T3QOT/N9EfHAwn/In0MP1uT9Q+jNS/7DI/Q/RfLDE8zlpfjDw/OekD0yw
PqwfKPqxvqDoS/wQaFj/APkDJvaH6kVhi/1jf0Hxl/0HxX/ixeGY94N4CVD2
h3gS6Hm/WD1o5P37A9DBNZg=
          "]]}, "Charting`Private`Tag#240"]}}, <|
     "HighlightElements" -> <|
       "Label" -> {"XYLabel"}, "Ball" -> {"IndicatedBall"}|>, 
      "LayoutOptions" -> <|
       "PanelPlotLayout" -> <||>, "PlotRange" -> {{-1., 1.}, {-3., 8.}}, 
        "Frame" -> {{False, False}, {False, False}}, "AxesOrigin" -> {0, 0}, 
        "ImageSize" -> {576, 576/GoldenRatio}, "Axes" -> {True, True}, 
        "LabelStyle" -> {}, "AspectRatio" -> GoldenRatio^(-1), "DefaultStyle" -> {
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]], 
          Directive[
           PointSize[
            Rational[1, 360]], 
           AbsoluteThickness[2], 
           Opacity[0.4], 
           RGBColor[0, 0, 1]]}, 
        "HighlightLabelingFunctions" -> <|"CoordinatesToolOptions" -> ({
            (Identity[#]& )[
             Part[#, 1]], 
            (Identity[#]& )[
             Part[#, 2]]}& ), 
          "ScalingFunctions" -> {{Identity, Identity}, {
            Identity, Identity}}|>, "Primitives" -> {}, "GCFlag" -> False|>, 
      "Meta" -> <|
       "DefaultHighlight" -> {"Dynamic", None}, "Index" -> {}, "Function" -> 
        ListPlot, "GroupHighlight" -> False|>|>, 
     "DynamicHighlight"]], {{}, {}}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{
    FormBox[
     TagBox["\"\\!\\(\\*SubscriptBox[\\(k\\), \\(y\\)]\\)\"", HoldForm], 
     TraditionalForm], 
    FormBox[
     TagBox["\"Energy\"", HoldForm], TraditionalForm]},
  AxesOrigin->{0, 0},
  DisplayFunction->Identity,
  Frame->{{False, False}, {False, False}},
  FrameLabel->{{None, None}, {None, None}},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{Automatic, Automatic},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  ImageSize->Large,
  Method->{
   "AxisPadding" -> Scaled[0.02], "DefaultBoundaryStyle" -> Automatic, 
    "DefaultGraphicsInteraction" -> {
     "Version" -> 1.2, "TrackMousePosition" -> {True, False}, 
      "Effects" -> {
       "Highlight" -> {"ratio" -> 2}, "HighlightPoint" -> {"ratio" -> 2}, 
        "Droplines" -> {
         "freeformCursorMode" -> True, 
          "placement" -> {"x" -> "All", "y" -> "None"}}}}, "DefaultMeshStyle" -> 
    AbsolutePointSize[6], "DefaultPlotStyle" -> {
      Directive[
       RGBColor[0.24, 0.6, 0.8], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.95, 0.627, 0.1425], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.455, 0.7, 0.21], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.922526, 0.385626, 0.209179], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.578, 0.51, 0.85], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.772079, 0.431554, 0.102387], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.4, 0.64, 1.], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[1., 0.75, 0.], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.8, 0.4, 0.76], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.637, 0.65, 0.], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.915, 0.3325, 0.2125], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.40082222609352647`, 0.5220066643438841, 0.85], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.9728288904374106, 0.621644452187053, 0.07336199581899142], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.736782672705901, 0.358, 0.5030266573755369], 
       AbsoluteThickness[2]], 
      Directive[
       RGBColor[0.28026441037696703`, 0.715, 0.4292089322474965], 
       AbsoluteThickness[2]]}, "DomainPadding" -> Scaled[0.02], 
    "PointSizeFunction" -> "SmallPointSize", "RangePadding" -> Scaled[0.05], 
    "OptimizePlotMarkers" -> True, "IncludeHighlighting" -> "CurrentSet", 
    "HighlightStyle" -> Automatic, "OptimizePlotMarkers" -> True, 
    "CoordinatesToolOptions" -> {"DisplayFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& ), "CopiedValueFunction" -> ({
        (Identity[#]& )[
         Part[#, 1]], 
        (Identity[#]& )[
         Part[#, 2]]}& )}},
  PlotLabel->FormBox["\"Ribbon Band Structure (W=80)\"", TraditionalForm],
  PlotRange->{{-1., 1.}, {-3., 8.}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {0, 0}},
  Ticks->{Automatic, Automatic}]], "Output",
 CellChangeTimes->{
  3.978314920303796*^9, 3.9783150049481573`*^9, {3.9783151159964533`*^9, 
   3.978315144130529*^9}, 3.978315187929742*^9, 3.978315231643549*^9, 
   3.978319370398993*^9, 3.978319401086382*^9, 3.978324988624393*^9, 
   3.97832525171885*^9, 3.978325282054778*^9, 3.978325513695347*^9, 
   3.978325559193316*^9, 3.978325589457165*^9, 3.978325623725822*^9, {
   3.9783256558582363`*^9, 3.978325682528738*^9}, {3.978329403712688*^9, 
   3.978329426223566*^9}},
 CellLabel->"Out[41]=",ImageCache->GraphicsData["CompressedBitmap", "\<\
eJzsvXfYFdXVPrycmXOeRq8WVBTFhghiQYIFReyK2BXpHUWaNJFepDeRDoLY
e9eYmBh77C0m1qjRGKNJNDHGKJ7v2mvfa+Y+20Hf/PL6/vFdcl3n8Jw5c2b2
7LLute5V9km9Rw/qf2Hv0YP79m5+zMjewwcN7juqeZeLRl7Ye3S8jUgsItuU
mkuyjUhJ5Dve3JnffXS0HigNGDBAP87zX9XX93jA5MmTxf7dsvVj7uf/k/PK
ju35461+vNWPt/rxVj/e6sdb/XirH2+Vd0zv9P+TZ/nxVj/e6sdb/XirH2/1
463+X261yR/rA9Pdm/L+/e9C/+L/8ya1RXMW66e++t7zf7lJ9fxXX4uUvtlm
m9I37o636ntsn/XTVf5YSeTEksie34g8JZU4NmDAgPS8W3J+GxzLuf2W/9nt
C9+IfF4SGVzyQ9TtG5F3pfjfN0M7srb2T7wlinxbttmm5Ft1tv6ZfLPNNs+V
RI4oiTT5ZpttHiu4w0XleNxfPd2bXqPZfzbay/yxChE5Fi+p1veq/XFKQxE5
TUTq4nMkIveKyG/ch8J/Pwv+w6Y247VSre+Fu3DKbjh+nLVTJF4gIp/aNZL/
8+a60W2Ol1Tre1UTyf49JSJviUgvEZkgIn8VkQ3/xz17lb4XG4jItSLyoYj8
UURWuHn5f9uS/wXR61d1crxI6Wc77/zOIpGSe0UL3dt89zZPpBTPdX9d5t5m
u7dZbuLsOUOkNF2kNFWkNFmkdKlIaYJIabxIaYxIabRIaYRIabhI6UKR0lCR
0hCR0kCRUn+RUh+RUm+R0vkipXNFSmeJlLqJlE4RKbkGdREpHSVSOkyk1EGk
dLBIqa1IqbVIaW+R0u4ipV1ESjuIlJqKlBqIlGqJlIquiSKlsf9Fl43R9z0S
kVK1SKmeSKkJbrWzSKmFSKmlSKmVSKmNSOlAkVJ7kVJHkdLhIqWjRUrHipRO
Eil1FSmdLlI6R6TUXaTUE4/dD10xCN3iumgYumwUunAsunMiuncKutt1vegw
xLPToZmbDtd8FcELMZiLMLjuTNmLxz12Xf7Ettt+eJX7qr2+N7tSpLRWpLRS
pHQ5fu6uOhvDPRnDPAZDOxTP0RvDeDqeuwv6oj2GbW/0m+vDRhgq17/n/RfD
dI6+7xjRMDXFELXETDkQw3IUZlVXzLTzMQuHoNtHobsnootd57oedb24VKR0
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
QIpuybCsaV6gpJUt+SSI638n2IzxN4Rlz+bYbOIT3xvalt6G9ob+Fg95OwXb
XB/E8HPNU9oSqd26IOGfKynbDvJWlHwuheGupzqR8ykr21xpFoC0EKvDpp9t
pziJ0slm0S4I48k5PpFc0lMp2NE4fSvlMy0N7/Kr9gqR292SWyTyPpbcv78Q
qXOdW4WI6d/cps1zI739O+k6kc3jsqDqj5wSf43IcpxbHELUpCUaDU5V3NiE
hkKILzwc9/t2EL8WdTwbMkh8wQwtW9W3HN7UTjgdktjC2i2G7gRgS/9UFBbP
h9J+NARvOxhTPviveACE6PG4c7kcrumNC3bDKUfBIDG82x32FIn8ejuA9NsN
Ir81gPBgYGxI8p0Bq9JIvp19fxhi+U9eTzD+cqGI/E5EIr/inIu7ZMWDdmUM
3N01cHnHjg+f7JXC9g+KdD+BMsgtjaGL14E7PyRyuvXoMSJfuMvOENlszK/F
fh6Ih9oPHbEX8G832KQ7wejc1u0PDfd8XZeoph2l9SDqOcq1KTpvV7Cjraiz
DiXnnykwzDc2ybxyhpVHo4/3R5Mk2k3P2R2Xb43md0HfKxB6N23SD2N9AuDd
R7YWLBz0GGgC/TLsrDib0iyMiu5mHIOfr4U+QdyLqmCVmcY3kLiL8i3F0pVl
PsTyCMoKp1a+U6/e0SOzncZ0vDaJbMaM6XChFw5bZopsmZGVdnj/G1HOat4l
lJrHqvEwCKSlhJGW9GmW4UJy6F8KwbUKmGvR1iYwZ1GewnoItGm41jpyJM4n
rGR30Goq2ruJoizT8AdlQhvekLND3h1BNc07KX7FIistOuNxqv0ovpBy/Zdo
F+Xf5dCff6JASobQvDy5z2wCuH+H5WAocLUBTNKvMgzdkwui5GGoef7ey4ma
5IhJS2w3DH2cKp38kqJTHiA78F7KSuQcOI4b8jznTmbDW77/KtKC1lEMrcXZ
ziE70KKd5lF6geXoWJnK2VSCyLgI3ZLHb/0ygzzZ40kRDCezpzYLo2lftBnl
QKmlBa24/AxP/s74u0gjLL9Bfg4c/LRIP6ucdXXr1i/qt+7yW7yejKWkS+4O
kXnDU2zUPWwGU1lgqj2pcqM75aWdnzFOKndOISluESS9M9mkpNfJgJufpOIs
OQRS8jTo9V741e8Dzf94CL92JNN3h1xvSQK0Uw5mmt3ERTu64jzjNM1LtR+M
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
gV2zCs/ReJx3k7hEsq6rC20QgqFmXBO+N7JeEJIhKQhtbyE4UbYF6d8BAZ0Q
jHKHALw3CUHFZgGCn5EC136cxjEYp0OoZLLxQgDKAVgoFtNul7Gse4T7ihIC
98OIXhf5OQIvvQHmTkrb+QxyxGdxOi8hV2R/S0cMyFxGbUAWRIOAJkm/KLPf
f8alAHT8/9Yvwvd2hf+Wc5n+YcAsOfuA/yFVVZJ7ErHyNWd2nHTXXLcvwBc+
J1OKn5SRBCoDXpNbQ7jJFcRQV0QNkAJJh/Ao3C/T3pfgpHYJK+dmnMsZ+NYN
gm36hNP3I6l6s7xm05ZFt+Gr99l5J2uo2/z9kkEmhnWyMbifCUrh/qOfbER5
q9r2k/MRYk9E0cd72TT0ZglZ83RYGH4TqK8XwCn1gHMZh6M4NdbesG2FsElT
cX6osS7DQQfjLQQwFsENBaQNZnpqkTOYlc+c02vmpaXitV4wkxOkipw0S2CI
ZJ11Oiw2BSmYQGUjg/Se8/YcoKYVThyKnGdlOKVRAvbhbMJ8WNpaQcvCz0UY
f6jXXNuvX7+/rFy5MjEmPrdr166J9wzKzc21vGbHDpI/9ceJlwhhTU+hLesi
qr1FuDh3tCEL2aLJ4bxKa2bi+DqP2EWwIsSDsKK4jD7CKxenrXCG8crx2cQx
27Ki5d20eCrOqS+OOxUrJgq4WQ1wqQT/5gvDTXt8djRutj61nns0o+gsm+Sj
GtAVXzfPnsCLr8ZXDZEi+igGhUg2E4eeLrQIE60tZpLNScLp3eh7yuhixDL8
WgRVTVJ65wZOfMsqvC2ZZ4aNG41vE0feDIOxF5kmHO+MjQEjDRulBkbGxT3w
cIQyMB24G4u4R6ijNgmRxlGYswvoG+4T3hRO/l1yOFY4tXdeRhauS7H1MbjO
J4RPhZpKL+N8lIjsLWdC79uCgNF+oot8eddO5Yz7/BOuHdWZ/7fu04NyRwrg
6sV9Fn4UMO6gNCw/lrLtd0Sv8B1HV56u80W40udEqwrqxv10tOGmcAJwQP2S
MICekZGUOwXZyRb2VWlln8W93oJI7ILUSzgWc7uoJ52UUYe1QnW2x3+eIyRx
kWc8SnbRvTZuZqMgj/0+pJEKbKIfcHZerWxSlrhm2/i1eQJLXOQ3JucL3X/i
yDViTZqQO/SH8e0Lr1QvgX4dLEh/GONM+NeRmhR4Z5vtBvEkNmN1jGMKWYJM
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
47prZ8586K4BA77rXRYn7p6kewTuJ7rvct+/Z9Gi+84PHvwtvCd214AB33dP
0m3qdX/uHoH7e96PozdWVj7jZq3dHx+ZOvUx9yickPezS/36fffg7NkPNu3d
e8j9msv9+n0fP4u419a9Zrvq6i65h+S9HL5j4MDv7Fyy5K7DM2Y8iiMI3zpy
5AvuUZkjx/vODhv2ytEpU540//Jei50aPfr5i4MHf8f9l/t/9+93DBr0He/H
/e/u2/cH95aV/Uh+7Jq3uNlD9+8PlpT80v23+3e3cP1It26vu39/tFu31x/r
2vV115HErb24SdnvDRnyTZfYuu58LxQXv/Vw9+6vP92hw5vuz13O9kJx8e+e
ad/+dy+1afPWy0VFb/1HUdHvv1lY+MdvFxS8/T3v///z09zcd36Wm/vnn+Xm
/uVX2dl//XVm5rtvpqd/+PvU1I/ejsc/+Ws0+tmH4fDf/xEK/ePvLVr830fh
8N+/1br1H9wbcJ33dO286qqrftmxY8fPIpHI14cPH7529+7dTtT9WcyF2xPm
XVnHJk164p1Y7LPPQqF//KNFi//7NBT6x/vR6Gfua39MTf3od2lpH/5XZuZ7
r2dmvv+rrKy//jw3990f5ef/T+iH7n++3br1H53iVwoL33JP4Jn27d98pbDw
j0926vTrVwoL//BIt26/+o82bX7vjhx/sajodw/16PFL92K91rv3T90L616E
+3v1eu2+0tKfPNW+/Zv3lpX9+L7S0h99rUuX/3QvqPse9wK74gr3YrtTHN2L
GkqsxR/IvXL/f3bYsJfloTw5evSz7qNCP3vlhurqJ/DEuDZ47sKmB848Me5K
c5eKPFnuYl6/Zctxd0HjtchtI0a8tOGqq27etGbNLWdGjHgZz7mLAe7CdC+r
u97db8evRG8aN+4Z92Pcn21dseLcrSNHviRf4Z6Fu/jdn8tSdJ97F08S7/ih
E3axxT088w68z8UTFwhcsHCwtN2leXD27IfWbtt21Il479vS1HTGPXvzPgCG
u/bc09tdW3uPu/Q9bImu3bbtBnctuW93L6hZrnHvNNxV7SKHu9q3L1t2h/tr
To75vRz375vWrLl155Ill90r6x7W0SlTvuaemnu1T44d++wtFRUvuFfPvdLn
Bw9+1T0cFz3c7/COKuwirbsszYdmuP8tZgqb4nJzF88KQc6y/KD+/0ELIUPC
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
Hogc38OTfILXRf9/8CROrpNYCor+t0SV/QMJ/j9NxQ12H6XfBGe4Hx9nM+0+
OkU5iYim7DG6WSLBFDDWQ7L2NtN+qmPFblUe0t/4Wj/YCQOuMzCvyozG0Ti0
KSgucBAnED/eyFeiZr6S7AOkTmH3QNL+431qnVbyu4zW7ii9PKgxygOM9iXD
ogZQ1QNrD97eu/dvZll+aKkuJ+nkGAmicz4Tv2ocieL2xIXGe+8s3aACpIVM
oZParAn5jTBeqypPEmHqZviNMN6O/IuSXO9A95zzD8snAUnUZxpCkn8G8XFw
+ycgl6NVn2oWp5XRAJyCX81pa7HPthCavuClabJjVvwG75g9iO+thMEsATqw
A2FYdLLPwX9coBXYdyIDeQIgyCtU1HxNcOavEYSa+9j+Zedrr1nOnXPu7v/n
+hL3f4Ef5UtaB2DzH6Hu+RcpTAqz9WkaFZLRodNUv51FtnEO2YhIh+8gzOgQ
UVl54yz7E14VVVsPKZ4XEo0k3FS+Nob2gjJRpFkM9q7g26b+hbWCBaQVfLXM
xAKbZIynVzaBpjrkaWTWs8S5n+C5hEm2Nxoz42BmQs5wrDohgLfpZAjqT4Qj
lsVoTr7iKyepiq9kdSqSNpeXX35hwoQrx0eMeOGGMWOePjBx4uM2/rpj5sz7
t8yde8eGqqrzaxYvvmnFypU3Ltm4cb9TL4Xtv9rfsl96Ytiw521PZkXsN7NC
F3v2/M2NY8Y8bX9/4fbt14fUj4Tsv66vqTlvv4v9kpB6dfC23r1/Y0shLN60
aZ8VUC8NLtqyZdfOkpL7LxQWvuF8BCto/93+mv09ed36mpoLt/bt+yv1ioD6
b/joyJHPLL3uukP2K7aWld2trgzfu9Sz51u7iosfsi/FpsrYsnby++0Pvmzd
usOnBw9+Ea8PXuzZ8y37JtjvK687Mnr0Mztmzrzb/l14XeTYyJG/ODV48Iv2
v+z/39a7969tlWDn2+0u9ez5pv1y+fa9nTq9d0ePHm/bf/9Zx44f3NOly3v2
3x/Lz/+T/e+7unX77fO5uR/d3aXL+4+3afPXJ1u3/stD7dt/+HJ29scPFxR8
+GpW1qdP5OX96bWsrE9fyMn5x+uZmZ+9npn5+dsZGV++k5Hx5fuNG3/zp5SU
7/+emPjvT+Pj/+d34fD//l+BwP/5r2Dw//k8Lu6/7VtuZTu38PLOnTvtv6l/
XVb/jb7etWvX75KSkk7Pnj37ZFlZ2b/j4+Pf7NSp05GKigpLPc2I7Wbu9/kN
Weq/KfaJ+X3jxt/8MxSSd/7fX8bF/c9/JCT855+Tk//5YWrqd79r3PjrN5s2
/fKNzMwvXsvM/Oy1rKyPAy/m5HxspT+Xm/u353JzP7qSn/8n+0bc17nz717K
yfn47m7d3nsyL+8vP2/X7o93dO/+zlN5eX+5q1u3d+2b93BBwR/uxN/v7tLl
PfvreOz255V7bz/SmwYNepke8W/2T5r0iP2nfO3U0KEv2o/99t695REH7Z9Z
tXTpCToeITke9n5mO5HH213u0eNt2y4Wbt++255LsZXmcXrkdB6wb9O22bPv
pNNpv+LtQ0VFT9i2JSfcvpEnhg17wX3FO1bw6MiRz61avvyUegVed11t7blT
Q4e+7FyY87ozgwa9urOk5F77/ayw87rla9ceta1NnfyId732NR4uKnrCviab
jQpcJMn+DLZV2O+3rq7u7KbKykvbZs++295xtm/SpEftn7E/0/NTpjxmuxDl
VXJc/1hf26YR/F8HeHeFdqFtU4HMph3SDhIvKTSymIn0MpbU7yAlBDFrekoD
iorGCXpSqmUocYZEZDHB0iYcOw9pX7pWmgRFGXsQXUph7BLiyBCf+RoPhcmu
NuZrWGHjOkM9Vchnx2i74gmCXzeS1vUlZC93ILw7q8wSniTlgfeJGCYZwlmk
adn1JisR+yl/bFnWFnxZip7wNeYoTh6UPBxl1je0u1FkTV5GWvU4cpQ73YVs
51WCfYSEL2U0cQNJ0B4joi+LuW2mntgygzfPvbMaQ0u42merWSmwCrO9k+GT
0RoytOGpSIgDOPZ1xnWIoJKRpKiEvYsBFjbnARJqCw8X0JcGhAca7d5amIEU
QeClZaB+KMGloeNbiRKqFxAUhar4cQB+cG1ZWEYGCmOHehW2JGBrO30QyG3v
cidqFuyfVwiIiN0sunnVyKl4GWtKbK9cg0Fa6w89zNVnsr5vTqV08VT4Ut2b
psNnQZmxIKJRpNBnfMajMRZUG6ugl5GfWEegIIutHcSRXwtzWYl0XrTxDwJT
PUUcd9HEf4KIIO+g7/o1oIkvgJQ0d9D0mId8h/OQR1qW9b8sy+pPTuKavYTj
gBK3oqP8PXzUP2gz2cvglz3sboRWg0ApZ4CG7Keu1BkgHtcDYxXpEtGss12m
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
dZqk6GHjC90rHOIktSr94PUV3Sg3I2VaKNaOeBLloQmfXoOgHRSSDd8w2oo8
Bm6qfV431w72snOxmnkyta6LVDLwZjWzJBvr6LYi0iRlp9odcT/jZOkJoeOO
kwS1WVw6oUJE+rFyabvjON85jvO54zhTnV9gzC3SM7pQmX/EZO3XqnWK3vNg
ndrg+w61Z6ps5yB1U8sIWRHUxYzj1TqQkS449iccFdlNTWdzdwkJMSkVG7m0
pJIlN8rXLvs1ZSaDOe2o1VyWamMLcoQ3r8ITH23V6h3lOkZLV+gi4i9KZb1G
hhYPSL1qPlV0o7DKXVOP3jVc5EzgNjxc99WZoSr/ywibFWpyczO/ly0n7lL7
Hq1R3aaeUNsACLQ+I9QWyYLN0giwuNy5IQvL6OsIk3PMnwp8XhEf0CRba2zh
0LerLND9VGJrqH6lI+/9KtNwM6VqmiLbKJ0F4rHeZFBpyLT429Nq5eqFMGqm
uidT2NF0AaXQrjTk+iGqHHkZrp9VK4mSMJe6jzZqFl2X6fmYWuocthNfQA8q
lVAaEIrzB/OuellVKZ+oRMe0qtSbFk0nRLSErift76GJFJ5sc9XCHVBunsDo
IrXDXM6iTawCiojAVpyx/NAo2W9N2HCajz6sCjolP7qLyF/JIUtPho30AuSV
VcGypopQb3gF+cQeRNPEUM5bMoLZKpkdkv4kLf3SC16KMOuoyW0p0xhYvh+q
cdhKIjpsNfHUTYWFr3Vzte/QWUOH62wlZXiNy0cMJplcdW+51Getwze5G8AX
1qvdJ6l9j+SYNAVTedqEuWq1miyQuJuseZABwh1UWuuIQMfzmHEmnqMnf1I5
aReZh5slrzqpCpAjXJvRBp8xz0aNklNTIPeCmtDeo6qc1lJ57uD4b1Z9tcsY
VN0VXlFl6DPNdUyW67lXkHVXy49VMqIbLU867digYPI3WQeZ0rS0DnEnM9zu
rHUjtZx6Q+fOx7q53a4YtHlJVgVGssyup1ogwulG06DvOj5VSuhuDBVPTFKb
yrcJbydq4DTEtQB9Wnk41Z5Fss9T6eZNVEDS7H+JsoOrVbuKfWpjj7epxH7H
/09ItgZPmVwFSFk4xjSkq/QBvfrf0Rae4PP/LQhzz4OGONvVjqWrKSuO5z6D
h6kqG7Ig5D9pxe5eUaiXCJRS6hsRHGqnDeMh96I/lOKO1eg/yWJzPcPWVJUw
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
\
\>", "ImageResolution" -> \
96.],ExpressionUUID->"45689fca-ea2d-4a28-a392-129a4dcbb637"]
}, Open  ]],

Cell[BoxData[""], "Input",
 CellChangeTimes->{{3.978333977032365*^9, 
  3.978333985250877*^9}},ExpressionUUID->"caddb1a9-5751-4bf1-b1ea-\
60d4ee99fab8"]
},
WindowSize->{855, 670.5},
WindowMargins->{{Automatic, 6}, {Automatic, 6}},
FrontEndVersion->"14.2 for Linux x86 (64-bit) (December 26, 2024)",
StyleDefinitions->"Default.nb",
ExpressionUUID->"958ba150-fd14-4dcc-8cf7-b742d1bcdca2"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[576, 22, 13274, 382, 992, "Input",ExpressionUUID->"1c5d6259-97a0-4c75-abb3-e912dd23b2b4"],
Cell[13853, 406, 16791, 406, 134, "Output",ExpressionUUID->"1340d16c-b92d-48f7-bd5a-124cda63c945"]
}, Open  ]],
Cell[CellGroupData[{
Cell[30681, 817, 5705, 149, 715, "Input",ExpressionUUID->"0f1d8b39-2db4-4462-a887-ba7d55d0022f"],
Cell[36389, 968, 3662, 91, 159, "Output",ExpressionUUID->"d4a28731-e582-4b34-a280-6ec73230ad18"],
Cell[40054, 1061, 4181, 106, 188, "Output",ExpressionUUID->"8f150d74-d4f0-4a33-ac08-72a93df442e5"],
Cell[44238, 1169, 4229, 108, 188, "Output",ExpressionUUID->"5b4b20ff-d6e7-4c6a-b8b3-f474eb517ae2"],
Cell[48470, 1279, 886, 21, 60, "Output",ExpressionUUID->"ab3c45c4-4016-486d-9280-394e11d0d293"],
Cell[49359, 1302, 886, 21, 60, "Output",ExpressionUUID->"18d1ec88-cb5b-4c1b-a7f8-4af1d7a41da3"],
Cell[CellGroupData[{
Cell[50270, 1327, 517, 11, 23, "Print",ExpressionUUID->"ecbd28a4-22d7-4c16-ad10-df2eefd87ad2"],
Cell[50790, 1340, 521, 11, 23, "Print",ExpressionUUID->"17bb0ab3-05c5-49e2-beeb-175521372910"],
Cell[51314, 1353, 521, 11, 23, "Print",ExpressionUUID->"b94b0343-ef36-4d7c-9382-c692bb850478"]
}, Open  ]]
}, Open  ]],
Cell[51862, 1368, 227, 4, 29, "Input",ExpressionUUID->"bad43479-a4f7-4d3a-aca1-88961985c62f"],
Cell[52092, 1374, 225, 4, 29, "Input",ExpressionUUID->"2e815ed6-5425-4fc3-b7ec-d8a988490691"],
Cell[52320, 1380, 152, 3, 29, "Input",ExpressionUUID->"a161731d-6117-45cd-b46a-8470cc050ac7"],
Cell[CellGroupData[{
Cell[52497, 1387, 6194, 157, 637, "Input",ExpressionUUID->"cf6f07b5-e9d1-44d7-801a-af7e93ff9b68"],
Cell[58694, 1546, 821210, 19041, 399, 647818, 16197, "CachedBoxData", "BoxData", "Output",ExpressionUUID->"45689fca-ea2d-4a28-a392-129a4dcbb637"]
}, Open  ]],
Cell[879919, 20590, 152, 3, 29, "Input",ExpressionUUID->"caddb1a9-5751-4bf1-b1ea-60d4ee99fab8"]
}
]
*)

