(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 11.1' *)

(*************************************************************************)
(*                                                                       *)
(*  The Mathematica License under which this file was created prohibits  *)
(*  restricting third parties in receipt of this file from republishing  *)
(*  or redistributing it by any means, including but not limited to      *)
(*  rights management or terms of use, without the express consent of    *)
(*  Wolfram Research, Inc. For additional information concerning CDF     *)
(*  licensing and redistribution see:                                    *)
(*                                                                       *)
(*        www.wolfram.com/cdf/adopting-cdf/licensing-options.html        *)
(*                                                                       *)
(*************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1064,         20]
NotebookDataLength[     43076,       1118]
NotebookOptionsPosition[     38403,        986]
NotebookOutlinePosition[     38904,       1008]
CellTagsIndexPosition[     38861,       1005]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell["CEFR sentence classification", "Title",ExpressionUUID->"cf99e9d2-40ae-4844-b835-90ed36bd38f0"],

Cell["\<\
We will try to build a classifier for the sentences labeled by CEFR level of \
difficulty.\
\>", "Text",ExpressionUUID->"7e0ff946-ca94-463d-9b2f-f3765a336c14"],

Cell[BoxData[
 RowBox[{
  RowBox[{"levelNames", " ", "=", 
   RowBox[{"{", 
    RowBox[{
    "\"\<a1\>\"", ",", "\"\<a2\>\"", ",", "\"\<b1\>\"", ",", "\"\<b2\>\""}], 
    "}"}]}], ";"}]], "Input",ExpressionUUID->"9b20005d-057f-46c1-ac8c-\
1158c961d2ad"],

Cell[CellGroupData[{

Cell["Reading the data", "Chapter",ExpressionUUID->"e7038ba2-24ab-467f-8b12-80b64323e3c7"],

Cell[BoxData[
 RowBox[{
  RowBox[{"rootPath", " ", "=", " ", 
   RowBox[{"NotebookDirectory", "[", "]"}]}], ";"}]], "Input",ExpressionUUID->\
"83938e1b-d416-4715-b97d-04e6b2b5d76e"],

Cell[BoxData[
 RowBox[{
  RowBox[{"texts", " ", "=", " ", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"Import", "[", " ", 
      RowBox[{"FileNameJoin", "[", 
       RowBox[{"{", 
        RowBox[{
        "rootPath", " ", ",", " ", "\"\<data\>\"", ",", "\"\<sentences\>\"", 
         " ", ",", 
         RowBox[{"StringJoin", "[", " ", 
          RowBox[{"level", ",", "\"\< sentences.txt\>\""}], "]"}]}], "}"}], 
       "]"}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"level", ",", "levelNames"}], "}"}]}], "]"}]}], ";"}]], "Input",\
ExpressionUUID->"e697d91d-9bd9-4b57-8e8a-a54c954010af"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"TextSentences", "[", 
   RowBox[{
    RowBox[{"texts", "[", 
     RowBox[{"[", "1", "]"}], "]"}], ",", "4"}], "]"}], " ", 
  RowBox[{"(*", 
   RowBox[{
    RowBox[{"Show", " ", "4", " ", "sentences"}], ",", " ", 
    RowBox[{"only", " ", "A1", " ", "level"}]}], "*)"}]}]], "Input",Expression\
UUID->"90602f06-bf07-487a-af54-8f353306fc59"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"I would like that, my dear.\"\>", 
   ",", "\<\"I would like to order  la carte.\"\>", 
   ",", "\<\"I would like to compose a message.\"\>", 
   ",", "\<\"Beautiful work.\"\>"}], "}"}]], "Output",ExpressionUUID->\
"e8c334ee-b5e3-4f7e-b3bb-9c54e47e5db5"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"Flatten", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"TextSentences", "[", 
      RowBox[{"#", ",", "1"}], "]"}], "&"}], "@", "texts"}], "]"}], 
  RowBox[{"(*", 
   RowBox[{
    RowBox[{"Show", " ", "1", " ", "sentence"}], ",", " ", 
    RowBox[{"all", " ", "levels", " ", "in", " ", "one", " ", "array"}]}], 
   "*)"}]}]], "Input",ExpressionUUID->"a32eeffe-be91-4680-ad7c-184e776ae277"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"\<\"I would like that, my dear.\"\>", 
   ",", "\<\"That\[CloseCurlyQuote]s Speedy!\"\>", 
   ",", "\<\"And guess what?\"\>", ",", "\<\"He couldn't even guess.\"\>"}], 
  "}"}]], "Output",ExpressionUUID->"39d758af-3321-43b6-a6fd-0b3ba6caf1a3"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Pre-Processing", "Chapter",ExpressionUUID->"0cb2bf65-73db-41cc-a6ab-6ba06ab63b08"],

Cell[BoxData[
 RowBox[{
  RowBox[{"sentencesFull", "=", 
   RowBox[{"Map", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"Select", "[", 
       RowBox[{
        RowBox[{"StringSplit", "[", 
         RowBox[{"#", ",", "\"\<\\n\>\""}], "]"}], ",", 
        RowBox[{
         RowBox[{
          RowBox[{"StringLength", "[", "#", "]"}], ">=", "2"}], "&"}]}], 
       "]"}], "&"}], ",", "texts"}], "]"}]}], ";"}]], "Input",ExpressionUUID->\
"76bf8377-c98e-4d4c-82ae-e9e5dfa516f5"],

Cell[BoxData[
 RowBox[{
  RowBox[{
   RowBox[{"nSents", " ", "=", "All"}], ";"}], 
  RowBox[{"(*", 
   RowBox[{
   "reduce", " ", "number", " ", "of", " ", "sentences", " ", "if", " ", 
    "too", " ", "slow"}], "*)"}]}]], "Input",ExpressionUUID->"4561957e-a985-\
4844-a1f4-e9f0fc51de3b"],

Cell[BoxData[
 RowBox[{
  RowBox[{"sentences", "=", " ", 
   RowBox[{"Map", "[", 
    RowBox[{
     RowBox[{
      RowBox[{"Take", "[", 
       RowBox[{"#", ",", "nSents"}], "]"}], "&"}], ",", "sentencesFull"}], 
    "]"}]}], ";"}]], "Input",ExpressionUUID->"407b2eee-cd8a-4020-beaa-\
0aa25c0c4fa4"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"nameLength", "=", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{"levelNames", ",", 
      RowBox[{"Map", "[", 
       RowBox[{"Length", ",", "sentences"}], "]"}]}], "}"}], 
    "\[Transpose]"}]}], ";", 
  RowBox[{"nameLength", "//", "TableForm"}]}]], "Input",ExpressionUUID->\
"09ff462e-8ad3-44cf-b9d4-cad830757a15"],

Cell[BoxData[
 TagBox[GridBox[{
    {"\<\"a1\"\>", "2484"},
    {"\<\"a2\"\>", "5110"},
    {"\<\"b1\"\>", "6365"},
    {"\<\"b2\"\>", "4799"}
   },
   GridBoxAlignment->{
    "Columns" -> {{Left}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
     "RowsIndexed" -> {}},
   GridBoxSpacings->{"Columns" -> {
       Offset[0.27999999999999997`], {
        Offset[2.0999999999999996`]}, 
       Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
       Offset[0.2], {
        Offset[0.4]}, 
       Offset[0.2]}, "RowsIndexed" -> {}}],
  Function[BoxForm`e$, 
   TableForm[BoxForm`e$]]]], "Output",ExpressionUUID->"dc9f75ce-61ef-48be-\
aa5e-bf505a51e884"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"labels", "=", 
   RowBox[{"Flatten", "[", 
    RowBox[{"Table", "[", 
     RowBox[{
      RowBox[{"Table", "[", 
       RowBox[{
        RowBox[{"x", "[", 
         RowBox[{"[", "1", "]"}], "]"}], ",", 
        RowBox[{"x", "[", 
         RowBox[{"[", "2", "]"}], "]"}]}], "]"}], ",", 
      RowBox[{"{", 
       RowBox[{"x", ",", "nameLength"}], "}"}]}], "]"}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"aaf6e5a4-47b3-4317-91cc-16331da9c985"]
}, Open  ]],

Cell[CellGroupData[{

Cell["Modeling", "Chapter",ExpressionUUID->"4a6fc1b8-f112-4f0a-96a6-c5ccb50a4d63"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"embedding", "=", 
  RowBox[{
  "NetModel", "[", 
   "\"\<GloVe 50-Dimensional Word Vectors Trained on Wikipedia and Gigaword-5 \
Data\>\"", "]"}]}]], "Input",ExpressionUUID->"79f6ad76-2e27-4bf5-b86c-\
1d55b51b7247"],

Cell[BoxData[
 TagBox[
  TemplateBox[{RowBox[{
      StyleBox[
       TagBox["EmbeddingLayer", "SummaryHead"], "NonInterpretableSummary"], 
      StyleBox["[", "NonInterpretableSummary"], 
      DynamicModuleBox[{Typeset`open = False}, 
       PanelBox[
        PaneSelectorBox[{False -> GridBox[{{
              PaneBox[
               ButtonBox[
                DynamicBox[
                 FEPrivate`FrontEndResource[
                 "FEBitmaps", "SquarePlusIconMedium"]], 
                ButtonFunction :> (Typeset`open = True), Appearance -> None, 
                Evaluator -> Automatic, Method -> "Preemptive"], 
               Alignment -> {Center, Center}, ImageSize -> {Automatic, 24}], 
              GraphicsBox[
               
               GraphicsComplexBox[{{0, 0}, {-0.5, 1}, {0.5, 1}, {1.5, 1}, {1, 
                 0}}, {{
                  Opacity[0.3], 
                  LineBox[{{1, 2}, {1, 3}, {1, 4}, {5, 2}, {5, 3}, {5, 4}}]}, {
                  AbsolutePointSize[5], 
                  PointBox[{1, 5, 2, 3, 4}]}}], ImageSize -> 37], 
              GridBox[{{
                 ItemBox[
                  StyleBox["Parameters", Bold]], 
                 ItemBox[""]}, {
                 StyleBox[
                  TemplateBox[{"\"OutputDimension\"", "\":\""}, "RowDefault"],
                   "SummaryItemAnnotation"], 
                 StyleBox["50", "SummaryItem"]}, {
                 StyleBox[
                  TemplateBox[{"\"ClassCount\"", "\":\""}, "RowDefault"], 
                  "SummaryItemAnnotation"], 
                 StyleBox["400001", "SummaryItem"]}}, 
               GridBoxAlignment -> {
                "Columns" -> {{Left}}, "Rows" -> {{Automatic}}}, 
               GridBoxItemSize -> {
                "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
               GridBoxSpacings -> {
                "Columns" -> {{2}}, "Rows" -> {{Automatic}}}]}}, 
            GridBoxAlignment -> {"Rows" -> {{Top}}}, 
            GridBoxItemSize -> {
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
            BaselinePosition -> {1, 1}], True -> GridBox[{{
              PaneBox[
               ButtonBox[
                DynamicBox[
                 FEPrivate`FrontEndResource[
                 "FEBitmaps", "SquareMinusIconMedium"]], 
                ButtonFunction :> (Typeset`open = False), Appearance -> None, 
                Evaluator -> Automatic, Method -> "Preemptive"], 
               Alignment -> {Center, Center}, ImageSize -> {Automatic, 24}], 
              GraphicsBox[
               
               GraphicsComplexBox[{{0, 0}, {-0.5, 1}, {0.5, 1}, {1.5, 1}, {1, 
                 0}}, {{
                  Opacity[0.3], 
                  LineBox[{{1, 2}, {1, 3}, {1, 4}, {5, 2}, {5, 3}, {5, 4}}]}, {
                  AbsolutePointSize[5], 
                  PointBox[{1, 5, 2, 3, 4}]}}], ImageSize -> 37], 
              GridBox[{{
                 ItemBox[
                  StyleBox["Parameters", Bold]], 
                 ItemBox[""]}, {
                 StyleBox[
                  TemplateBox[{"\"OutputDimension\"", "\":\""}, "RowDefault"],
                   "SummaryItemAnnotation"], 
                 StyleBox["50", "SummaryItem"]}, {
                 StyleBox[
                  TemplateBox[{"\"ClassCount\"", "\":\""}, "RowDefault"], 
                  "SummaryItemAnnotation"], 
                 StyleBox["400001", "SummaryItem"]}, {
                 ItemBox[
                  StyleBox["Arrays", Bold], 
                  Frame -> {{False, False}, {False, True}}, FrameStyle -> 
                  GrayLevel[0.85]], 
                 ItemBox[
                  StyleBox[
                   
                   GraphicsBox[{}, ImageSize -> {1, 11}, 
                    BaselinePosition -> (Scaled[0.] -> Baseline)], 
                   "CacheGraphics" -> False], 
                  Frame -> {{False, False}, {False, True}}, FrameStyle -> 
                  GrayLevel[0.85]]}, {
                 StyleBox[
                  TemplateBox[{"\"Weights\"", "\":\""}, "RowDefault"], 
                  "SummaryItemAnnotation"], 
                 StyleBox[
                  TemplateBox[{"\"matrix\"", "\" \"", 
                    StyleBox[
                    
                    TemplateBox[{
                    "\"(\"", "\"\[VeryThinSpace]\"", "\"size\"", "\":\"", 
                    "\" \"", 
                    
                    TemplateBox[{
                    "\[Times]", "\"\[Times]\"", "\"400001\"", "\"50\""}, 
                    "RowWithSeparators"], "\"\[VeryThinSpace]\"", "\")\""}, 
                    "RowDefault"], 
                    GrayLevel[0.5], StripOnInput -> False]}, "RowDefault"], 
                  "SummaryItem"]}, {
                 ItemBox[
                  StyleBox["Ports", Bold], 
                  Frame -> {{False, False}, {False, True}}, FrameStyle -> 
                  GrayLevel[0.85]], 
                 ItemBox[
                  StyleBox[
                   
                   GraphicsBox[{}, ImageSize -> {1, 11}, 
                    BaselinePosition -> (Scaled[0.] -> Baseline)], 
                   "CacheGraphics" -> False], 
                  Frame -> {{False, False}, {False, True}}, FrameStyle -> 
                  GrayLevel[0.85]]}, {
                 StyleBox[
                  TemplateBox[{"\"Input\"", "\":\""}, "RowDefault"], 
                  "SummaryItemAnnotation"], 
                 StyleBox["\"string\"", "SummaryItem"]}, {
                 StyleBox[
                  TemplateBox[{"\"Output\"", "\":\""}, "RowDefault"], 
                  "SummaryItemAnnotation"], 
                 StyleBox[
                  TemplateBox[{"\"matrix\"", "\" \"", 
                    StyleBox[
                    
                    TemplateBox[{
                    "\"(\"", "\"\[VeryThinSpace]\"", "\"size\"", "\":\"", 
                    "\" \"", 
                    TemplateBox[{"\[Times]", "\"\[Times]\"", 
                    StyleBox[
                    SubscriptBox["\"n\"", 
                    StyleBox["\"1\"", 7, StripOnInput -> False]], Italic, 
                    StripOnInput -> False], "\"50\""}, "RowWithSeparators"], 
                    "\"\[VeryThinSpace]\"", "\")\""}, "RowDefault"], 
                    GrayLevel[0.5], StripOnInput -> False]}, "RowDefault"], 
                  "SummaryItem"]}}, 
               GridBoxAlignment -> {
                "Columns" -> {{Left}}, "Rows" -> {{Automatic}}}, 
               GridBoxItemSize -> {
                "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
               GridBoxSpacings -> {
                "Columns" -> {{2}}, "Rows" -> {{Automatic}}}]}}, 
            GridBoxAlignment -> {"Rows" -> {{Top}}}, 
            GridBoxItemSize -> {
             "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
            BaselinePosition -> {1, 1}]}, 
         Dynamic[Typeset`open], ImageSize -> Automatic], BaselinePosition -> 
        Baseline, 
        BaseStyle -> {
         ShowStringCharacters -> False, NumberMarks -> False, PrintPrecision -> 
          3, ShowSyntaxStyles -> False}]], 
      StyleBox["]", "NonInterpretableSummary"]}]},
   "CopyTag",
   DisplayFunction->(#& ),
   InterpretationFunction->("EmbeddingLayer[<>]"& )],
  False,
  Editable->False,
  SelectWithContents->True,
  Selectable->False]], "Output",ExpressionUUID->"2f73173e-c026-4c65-afc3-\
52b1f743fd4d"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"decoder", "=", 
  RowBox[{"NetDecoder", "[", 
   RowBox[{"{", 
    RowBox[{"\"\<Class\>\"", ",", "levelNames"}], "}"}], "]"}]}]], "Input",Exp\
ressionUUID->"77a4aa73-782b-4277-93c0-9c8edf1fe759"],

Cell[BoxData[
 TagBox[
  TemplateBox[{RowBox[{
      StyleBox[
       TagBox["NetDecoder", "SummaryHead"], "NonInterpretableSummary"], 
      StyleBox["[", "NonInterpretableSummary"], 
      PanelBox[
       GridBox[{{
          GridBox[{{
             StyleBox[
              TemplateBox[{"\"Type\"", "\":\""}, "RowDefault"], 
              "SummaryItemAnnotation"], 
             StyleBox["\"Class\"", "SummaryItem"]}, {
             StyleBox[
              TemplateBox[{"\"Labels\"", "\":\""}, "RowDefault"], 
              "SummaryItemAnnotation"], 
             StyleBox[
              TagBox[
               RowBox[{"{", 
                 
                 RowBox[{
                  "\"a1\"", ",", "\"a2\"", ",", "\"b1\"", ",", "\"b2\""}], 
                 "}"}], Short[#, 0.5]& ], "SummaryItem"]}, {
             StyleBox[
              TemplateBox[{"\"Dimensions\"", "\":\""}, "RowDefault"], 
              "SummaryItemAnnotation"], 
             StyleBox["4", "SummaryItem"]}}, 
           GridBoxAlignment -> {
            "Columns" -> {{Left}}, "Rows" -> {{Automatic}}}, 
           GridBoxItemSize -> {
            "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
           GridBoxSpacings -> {
            "Columns" -> {{2}}, "Rows" -> {{Automatic}}}]}}, 
        GridBoxAlignment -> {"Rows" -> {{Top}}}, 
        GridBoxItemSize -> {
         "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
        BaselinePosition -> {1, 1}], BaselinePosition -> Baseline, 
       BaseStyle -> {
        ShowStringCharacters -> False, NumberMarks -> False, PrintPrecision -> 
         3, ShowSyntaxStyles -> False}], 
      StyleBox["]", "NonInterpretableSummary"]}]},
   "CopyTag",
   DisplayFunction->(#& ),
   InterpretationFunction->("NetDecoder[<>]"& )],
  False,
  Editable->False,
  SelectWithContents->True,
  Selectable->False]], "Output",ExpressionUUID->"d701be7c-e74f-4244-89fa-\
3f1846e5fa4b"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"encoder", " ", "=", " ", 
   RowBox[{"NetEncoder", "[", "decoder", "]"}]}], ";"}]], "Input",ExpressionUU\
ID->"d5f5e435-19c1-4d89-a92a-66ed97002a14"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"encodedLabels", "=", 
   RowBox[{"Thread", "[", 
    RowBox[{"UnitVector", "[", 
     RowBox[{
      RowBox[{"Length", "[", "levelNames", "]"}], ",", 
      RowBox[{"encoder", "[", "labels", "]"}]}], "]"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"Dimensions", "[", "encodedLabels", "]"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"RandomSample", "[", 
   RowBox[{
    RowBox[{
     RowBox[{"{", 
      RowBox[{"labels", ",", "encodedLabels"}], "}"}], "\[Transpose]"}], ",", 
    "4"}], "]"}], "//", "TraditionalForm"}]}], "Input",ExpressionUUID->\
"d641b70d-9faa-4d22-9eed-0becb44f5451"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"18758", ",", "4"}], "}"}]], "Output",ExpressionUUID->"6fdb4d0d-5497-4dc5-a18c-dd860001112c"],

Cell[BoxData[
 FormBox[
  RowBox[{"(", "\[NoBreak]", GridBox[{
     {"\<\"b1\"\>", 
      RowBox[{"{", 
       RowBox[{"0", ",", "0", ",", "1", ",", "0"}], "}"}]},
     {"\<\"a2\"\>", 
      RowBox[{"{", 
       RowBox[{"0", ",", "1", ",", "0", ",", "0"}], "}"}]},
     {"\<\"b2\"\>", 
      RowBox[{"{", 
       RowBox[{"0", ",", "0", ",", "0", ",", "1"}], "}"}]},
     {"\<\"b1\"\>", 
      RowBox[{"{", 
       RowBox[{"0", ",", "0", ",", "1", ",", "0"}], "}"}]}
    },
    GridBoxAlignment->{
     "Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, 
      "RowsIndexed" -> {}},
    GridBoxSpacings->{"Columns" -> {
        Offset[0.27999999999999997`], {
         Offset[0.7]}, 
        Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {
        Offset[0.2], {
         Offset[0.4]}, 
        Offset[0.2]}, "RowsIndexed" -> {}}], "\[NoBreak]", ")"}], 
  TraditionalForm]], "Output",ExpressionUUID->"e25eda57-eb68-460c-9551-\
1b14de4eb575"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"encodedWords", "=", 
   RowBox[{"embedding", "[", 
    RowBox[{"Flatten", "[", "sentences", "]"}], "]"}]}], ";"}]], "Input",Expre\
ssionUUID->"8d86c694-b066-419a-bafa-3105e5354f40"],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{
  RowBox[{"encodedSentences", "=", 
   RowBox[{"Map", "[", 
    RowBox[{"Mean", ",", "encodedWords"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"Dimensions", "[", "encodedSentences", "]"}]}], "Input",ExpressionUUI\
D->"d2f0be2d-7c20-455c-91c8-bb50c97ee4a1"],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"18758", ",", "50"}], "}"}]], "Output",ExpressionUUID->"b2eda962-8e3e-4aa3-a4f0-4b38697b3946"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  RowBox[{"allData", "=", 
   RowBox[{"Thread", "[", 
    RowBox[{"encodedSentences", "\[Rule]", "encodedLabels"}], "]"}]}], ";", 
  RowBox[{"allData", "[", 
   RowBox[{"[", "1", "]"}], "]"}]}]], "Input",ExpressionUUID->"8f23a118-4d97-\
4b7a-b160-538db57df3c9"],

Cell[BoxData[
 RowBox[{
  RowBox[{"{", 
   RowBox[{
   "0.21401874907314777`", ",", "0.2712612561881542`", ",", 
    "0.05047712568193674`", ",", 
    RowBox[{"-", "0.2766743740066886`"}], ",", "0.502118743956089`", ",", 
    "0.058347249403595924`", ",", 
    RowBox[{"-", "0.4003250002861023`"}], ",", 
    RowBox[{"-", "0.020780371967703104`"}], ",", 
    RowBox[{"-", "0.2783949989825487`"}], ",", "0.011126196797704324`", ",", 
    RowBox[{"-", "0.10052824951708317`"}], ",", "0.6188675044104457`", ",", 
    RowBox[{"-", "0.4171387478709221`"}], ",", 
    RowBox[{"-", "0.1375253750011325`"}], ",", "0.6516012474894524`", ",", 
    "0.4040623642504215`", ",", 
    RowBox[{"-", "0.005945000797510147`"}], ",", "0.10508400062099099`", ",", 
    "0.13052512938156724`", ",", 
    RowBox[{"-", "0.43941375985741615`"}], ",", 
    RowBox[{"-", "0.22867374680936337`"}], ",", "0.428291997872293`", ",", 
    "0.37946162838488817`", ",", "0.0416914519155398`", ",", 
    "0.5285432420205325`", ",", 
    RowBox[{"-", "1.7352499961853027`"}], ",", 
    RowBox[{"-", "0.7892275135964155`"}], ",", "0.15574862086214125`", ",", 
    "0.446609009988606`", ",", 
    RowBox[{"-", "0.5539662502706051`"}], ",", "2.8036612644791603`", ",", 
    "0.3911722938064486`", ",", 
    RowBox[{"-", "0.3865737512242049`"}], ",", 
    RowBox[{"-", "0.000509750097990036`"}], ",", 
    RowBox[{"-", "0.11635603540344164`"}], ",", 
    RowBox[{"-", "0.1549274967983365`"}], ",", "0.13207999523729086`", ",", 
    "0.033448252361267805`", ",", "0.32164524449035525`", ",", 
    RowBox[{"-", "0.2725647478364408`"}], ",", 
    RowBox[{"-", "0.10971099868220335`"}], ",", "0.11948237288743258`", ",", 
    RowBox[{"-", "0.1387735221796902`"}], ",", "0.24213175009936094`", ",", 
    "0.1579171228222549`", ",", "0.1409869990311563`", ",", 
    RowBox[{"-", "0.21070537436753511`"}], ",", 
    RowBox[{"-", "0.20691249892115593`"}], ",", 
    RowBox[{"-", "0.06725049950182438`"}], ",", "0.3483169013634324`"}], 
   "}"}], "\[Rule]", 
  RowBox[{"{", 
   RowBox[{"1", ",", "0", ",", "0", ",", "0"}], "}"}]}]], "Output",ExpressionU\
UID->"4ac4d44c-057e-4095-b90a-ed296c877a1a"]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"trainingData", " ", "=", " ", 
   RowBox[{"RandomSample", "[", 
    RowBox[{"allData", ",", 
     RowBox[{"Round", "[", 
      RowBox[{"0.7", 
       RowBox[{"Length", "[", "allData", "]"}]}], "]"}]}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"42539ece-0f8e-482d-bf8e-767646654fed"],

Cell[BoxData[
 RowBox[{
  RowBox[{"testingData", "=", 
   RowBox[{"Complement", "[", 
    RowBox[{"allData", ",", "trainingData"}], "]"}]}], ";"}]], "Input",Express\
ionUUID->"a5d7d941-7db2-4ebb-abe1-e0a8ebff9fcf"],

Cell[BoxData[
 RowBox[{
  RowBox[{"net", "=", 
   RowBox[{"NetChain", "[", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"LinearLayer", "[", "20", "]"}], ",", 
       RowBox[{"ElementwiseLayer", "[", "Ramp", "]"}], ",", 
       RowBox[{"LinearLayer", "[", "]"}], ",", 
       RowBox[{"ElementwiseLayer", "[", "Ramp", "]"}]}], "}"}], ",", 
     RowBox[{"\"\<Input\>\"", "\[Rule]", "50"}], ",", 
     RowBox[{"\"\<Output\>\"", "\[Rule]", "decoder"}]}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"da7b4149-96e1-4140-94dc-483f0a3366fb"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"net", "=", 
  RowBox[{"NetTrain", "[", 
   RowBox[{"net", ",", "trainingData", ",", 
    RowBox[{"Method", "\[Rule]", "\"\<ADAM\>\""}], ",", 
    RowBox[{"ValidationSet", "\[Rule]", "testingData"}]}], "]"}]}]], "Input",E\
xpressionUUID->"aa1ad422-2ef0-47f7-b1a2-26be6fff2818"],

Cell[BoxData[
 StyleBox[
  TagBox[
   TagBox[
    RowBox[{"NetChain", 
     RowBox[{"[", 
      PanelBox[
       DynamicModuleBox[{NeuralNetworks`Private`NetChain`assoc3 = Association[
        "Type" -> "Chain", "Nodes" -> 
         Association[
          "1" -> Association[
            "Type" -> "Linear", "Arrays" -> 
             Association[
              "Weights" -> NeuralNetworks`Private`DummyRawArray[{20, 50}], 
               "Biases" -> NeuralNetworks`Private`DummyRawArray[{20}]], 
             "Parameters" -> 
             Association[
              "OutputDimensions" -> {20}, "$OutputSize" -> 20, "$InputSize" -> 
               50, "$InputDimensions" -> {50}], "Inputs" -> 
             Association[
              "Input" -> NeuralNetworks`TensorT[{50}, NeuralNetworks`RealT]], 
             "Outputs" -> 
             Association[
              "Output" -> 
               NeuralNetworks`TensorT[{20}, NeuralNetworks`RealT]]], "2" -> 
           Association[
            "Type" -> "Elementwise", "Arrays" -> Association[], "Parameters" -> 
             Association[
              "Function" -> NeuralNetworks`ValidatedParameter[Ramp], 
               "$Dimensions" -> {20}], "Inputs" -> 
             Association[
              "Input" -> NeuralNetworks`TensorT[{20}, NeuralNetworks`RealT]], 
             "Outputs" -> 
             Association[
              "Output" -> 
               NeuralNetworks`TensorT[{20}, NeuralNetworks`RealT]]], "3" -> 
           Association[
            "Type" -> "Linear", "Arrays" -> 
             Association[
              "Weights" -> NeuralNetworks`Private`DummyRawArray[{4, 20}], 
               "Biases" -> NeuralNetworks`Private`DummyRawArray[{4}]], 
             "Parameters" -> 
             Association[
              "OutputDimensions" -> {4}, "$OutputSize" -> 4, "$InputSize" -> 
               20, "$InputDimensions" -> {20}], "Inputs" -> 
             Association[
              "Input" -> NeuralNetworks`TensorT[{20}, NeuralNetworks`RealT]], 
             "Outputs" -> 
             Association[
              "Output" -> NeuralNetworks`TensorT[{4}, NeuralNetworks`RealT]]],
            "4" -> Association[
            "Type" -> "Elementwise", "Arrays" -> Association[], "Parameters" -> 
             Association[
              "Function" -> NeuralNetworks`ValidatedParameter[Ramp], 
               "$Dimensions" -> {4}], "Inputs" -> 
             Association[
              "Input" -> NeuralNetworks`TensorT[{4}, NeuralNetworks`RealT]], 
             "Outputs" -> 
             Association[
              "Output" -> 
               NeuralNetworks`TensorT[{4}, NeuralNetworks`RealT]]]], 
         "Edges" -> {
          NeuralNetworks`NetPath["Nodes", "1", "Inputs", "Input"] -> 
           NeuralNetworks`NetPath["Inputs", "Input"], 
           NeuralNetworks`NetPath["Nodes", "2", "Inputs", "Input"] -> 
           NeuralNetworks`NetPath["Nodes", "1", "Outputs", "Output"], 
           NeuralNetworks`NetPath["Nodes", "3", "Inputs", "Input"] -> 
           NeuralNetworks`NetPath["Nodes", "2", "Outputs", "Output"], 
           NeuralNetworks`NetPath["Nodes", "4", "Inputs", "Input"] -> 
           NeuralNetworks`NetPath["Nodes", "3", "Outputs", "Output"], 
           NeuralNetworks`NetPath["Outputs", "Output"] -> 
           NeuralNetworks`NetPath["Nodes", "4", "Outputs", "Output"]}, 
         "Inputs" -> 
         Association[
          "Input" -> NeuralNetworks`TensorT[{50}, NeuralNetworks`RealT]], 
         "Outputs" -> Association["Output" -> NetDecoder["Class", 
             Association[
             "Labels" -> {"a1", "a2", "b1", "b2"}, "Dimensions" -> 4], 
             NeuralNetworks`TensorT[{4}, NeuralNetworks`RealT]]]], 
        NeuralNetworks`Private`NetChain`opart, 
        NeuralNetworks`Private`NetChain`part, 
        NeuralNetworks`Private`NetChain`selected = Null}, 
        DynamicBox[GridBox[{{
            NeuralNetworks`Private`NetChain`MouseClickBoxes[
             TagBox[
              GridBox[{{
                 TagBox[
                  TagBox[
                  "\"\"", Annotation[#, {"Inputs", "Input"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                  "\"Input\"", Annotation[#, {"Inputs", "Input"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                   TemplateBox[{"\"vector\"", "\" \"", 
                    StyleBox[
                    
                    TemplateBox[{
                    "\"(\"", "\"\[VeryThinSpace]\"", "\"size\"", "\":\"", 
                    "\" \"", 
                    
                    TemplateBox[{"\[Times]", "\"\[Times]\"", "\"50\""}, 
                    "RowWithSeparators"], "\"\[VeryThinSpace]\"", "\")\""}, 
                    "RowDefault"], 
                    GrayLevel[0.5], StripOnInput -> False]}, "RowDefault"], 
                   Annotation[#, {"Inputs", "Input"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]]}, {
                 TagBox[
                  TagBox[
                   StyleBox["\"1\"", 
                    GrayLevel[0.5], StripOnInput -> False], 
                   Annotation[#, {"Nodes", "1"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                   StyleBox["LinearLayer", 
                    GrayLevel[0], StripOnInput -> False], 
                   Annotation[#, {"Nodes", "1"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                   TemplateBox[{"\"vector\"", "\" \"", 
                    StyleBox[
                    
                    TemplateBox[{
                    "\"(\"", "\"\[VeryThinSpace]\"", "\"size\"", "\":\"", 
                    "\" \"", 
                    
                    TemplateBox[{"\[Times]", "\"\[Times]\"", "\"20\""}, 
                    "RowWithSeparators"], "\"\[VeryThinSpace]\"", "\")\""}, 
                    "RowDefault"], 
                    GrayLevel[0.5], StripOnInput -> False]}, "RowDefault"], 
                   Annotation[#, {"Nodes", "1"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]]}, {
                 TagBox[
                  TagBox[
                   StyleBox["\"2\"", 
                    GrayLevel[0.5], StripOnInput -> False], 
                   Annotation[#, {"Nodes", "2"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                   StyleBox["Ramp", 
                    GrayLevel[0], StripOnInput -> False], 
                   Annotation[#, {"Nodes", "2"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                   TemplateBox[{"\"vector\"", "\" \"", 
                    StyleBox[
                    
                    TemplateBox[{
                    "\"(\"", "\"\[VeryThinSpace]\"", "\"size\"", "\":\"", 
                    "\" \"", 
                    
                    TemplateBox[{"\[Times]", "\"\[Times]\"", "\"20\""}, 
                    "RowWithSeparators"], "\"\[VeryThinSpace]\"", "\")\""}, 
                    "RowDefault"], 
                    GrayLevel[0.5], StripOnInput -> False]}, "RowDefault"], 
                   Annotation[#, {"Nodes", "2"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]]}, {
                 TagBox[
                  TagBox[
                   StyleBox["\"3\"", 
                    GrayLevel[0.5], StripOnInput -> False], 
                   Annotation[#, {"Nodes", "3"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                   StyleBox["LinearLayer", 
                    GrayLevel[0], StripOnInput -> False], 
                   Annotation[#, {"Nodes", "3"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                   TemplateBox[{"\"vector\"", "\" \"", 
                    StyleBox[
                    
                    TemplateBox[{
                    "\"(\"", "\"\[VeryThinSpace]\"", "\"size\"", "\":\"", 
                    "\" \"", 
                    
                    TemplateBox[{"\[Times]", "\"\[Times]\"", "\"4\""}, 
                    "RowWithSeparators"], "\"\[VeryThinSpace]\"", "\")\""}, 
                    "RowDefault"], 
                    GrayLevel[0.5], StripOnInput -> False]}, "RowDefault"], 
                   Annotation[#, {"Nodes", "3"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]]}, {
                 TagBox[
                  TagBox[
                   StyleBox["\"4\"", 
                    GrayLevel[0.5], StripOnInput -> False], 
                   Annotation[#, {"Nodes", "4"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                   StyleBox["Ramp", 
                    GrayLevel[0], StripOnInput -> False], 
                   Annotation[#, {"Nodes", "4"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                   TemplateBox[{"\"vector\"", "\" \"", 
                    StyleBox[
                    
                    TemplateBox[{
                    "\"(\"", "\"\[VeryThinSpace]\"", "\"size\"", "\":\"", 
                    "\" \"", 
                    
                    TemplateBox[{"\[Times]", "\"\[Times]\"", "\"4\""}, 
                    "RowWithSeparators"], "\"\[VeryThinSpace]\"", "\")\""}, 
                    "RowDefault"], 
                    GrayLevel[0.5], StripOnInput -> False]}, "RowDefault"], 
                   Annotation[#, {"Nodes", "4"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]]}, {
                 TagBox[
                  TagBox[
                  "\"\"", Annotation[#, {"Outputs", "Output"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                  "\"Output\"", 
                   Annotation[#, {"Outputs", "Output"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]], 
                 TagBox[
                  TagBox[
                  "\"class\"", 
                   Annotation[#, {"Outputs", "Output"}, "Mouse"]& ], 
                  MouseAppearanceTag["LinkHand"]]}}, 
               GridBoxAlignment -> {"Columns" -> {{Left}}}, AutoDelete -> 
               False, GridBoxItemSize -> {
                "Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}, 
               GridBoxSpacings -> {"Columns" -> {{1.1}}}], "Grid"], 
             If[
              ListQ[NeuralNetworks`Private`NetChain`part = MouseAnnotation[]],
               If[NeuralNetworks`Private`NetChain`opart === 
                NeuralNetworks`Private`NetChain`part, 
                NeuralNetworks`Private`NetChain`selected = Null; 
                NeuralNetworks`Private`NetChain`opart = Null, 
                NeuralNetworks`Private`NetChain`selected = 
                 Part[NeuralNetworks`Private`NetChain`assoc3, 
                   Apply[Sequence, NeuralNetworks`Private`NetChain`part]]; 
                NeuralNetworks`Private`NetChain`opart = 
                 NeuralNetworks`Private`NetChain`part; Null]; Null]]}, 
           NeuralNetworks`Private`NetChain`fmtSelected[
           NeuralNetworks`Private`NetChain`selected, 
            NeuralNetworks`Private`NetChain`part]}, 
          GridBoxSpacings -> {"Columns" -> {{1}}}, 
          GridBoxAlignment -> {"Columns" -> {{Left}}}],
         ImageSizeCache->{159., {40.4169921875, 45.5830078125}},
         TrackedSymbols:>{NeuralNetworks`Private`NetChain`selected}],
        Initialization:>{NetChain}],
       BaselinePosition->Automatic], "]"}]}],
    False],
   Deploy],
  LineBreakWithin->False]], "Output",ExpressionUUID->"d60939c9-0baf-4438-b346-\
b594c87579b0"]
}, Open  ]]
}, Open  ]],

Cell[CellGroupData[{

Cell["Evaluation", "Chapter",ExpressionUUID->"c0bf0315-48c1-4aec-a0af-424fef308487"],

Cell[BoxData[{
 RowBox[{
  RowBox[{"predict", "=", 
   RowBox[{"net", "[", 
    RowBox[{"Keys", "[", "testingData", "]"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"actual", "=", 
   RowBox[{"decoder", "[", 
    RowBox[{"Values", "[", "testingData", "]"}], "]"}]}], ";"}]}], "Input",Exp\
ressionUUID->"bc8160e5-2a4d-4253-8b12-53b1d23a13f1"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"countsNN", "=", 
  RowBox[{"Counts", "[", 
   RowBox[{"Table", "[", 
    RowBox[{
     RowBox[{"Apply", "[", 
      RowBox[{"Equal", ",", "z"}], "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"z", ",", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"predict", ",", "actual"}], "}"}], "\[Transpose]"}]}], 
      "}"}]}], "]"}], "]"}]}]], "Input",ExpressionUUID->"70cf8f14-118f-4ab2-\
9879-14d2271bb792"],

Cell[BoxData[
 RowBox[{"\[LeftAssociation]", 
  RowBox[{
   RowBox[{"True", "\[Rule]", "4232"}], ",", 
   RowBox[{"False", "\[Rule]", "1390"}]}], "\[RightAssociation]"}]], "Output",\
ExpressionUUID->"f4e72ad4-e1f2-478f-9130-54411a4d0ab0"]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{
  FractionBox[
   RowBox[{"countsNN", "[", "True", "]"}], 
   RowBox[{"Total", "[", "countsNN", "]"}]], "//", "N"}]], "Input",ExpressionU\
UID->"c5c1b0c0-0695-4c13-97fb-0847292ebc22"],

Cell[BoxData["0.7527570259694059`"], "Output",ExpressionUUID->"7f95bc04-82c1-45d2-b19c-b83b5ea87c9f"]
}, Open  ]],

Cell["\<\
And compare to plain Markov chain type classifier with same GloVe embeddings\
\>", "Text",ExpressionUUID->"447b0837-bb87-4719-94db-26996375f778"],

Cell[BoxData[
 RowBox[{
  RowBox[{"classifier", "=", 
   RowBox[{"Classify", "[", 
    RowBox[{
     RowBox[{"Keys", "[", "trainingData", "]"}], "\[Rule]", 
     RowBox[{"decoder", "[", 
      RowBox[{"Values", "[", "trainingData", "]"}], "]"}]}], "]"}]}], 
  ";"}]], "Input",ExpressionUUID->"7c31359d-fbc1-46ab-8cf0-a7ee4cf81d32"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"cm", "=", 
  RowBox[{"ClassifierMeasurements", "[", 
   RowBox[{"classifier", ",", 
    RowBox[{
     RowBox[{"Keys", "[", "testingData", "]"}], "\[Rule]", 
     RowBox[{"decoder", "[", 
      RowBox[{"Values", "[", "testingData", "]"}], "]"}]}], ",", 
    "\"\<Accuracy\>\""}], "]"}]}]], "Input",ExpressionUUID->"45e9a75a-a6a1-\
4cfc-9b49-37e80f787065"],

Cell[BoxData["0.6992173603699751`"], "Output",ExpressionUUID->"1021976b-2f18-49de-b9ad-8433941b5049"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
},
WindowSize->{777, 752},
Visible->True,
ScrollingOptions->{"VerticalScrollRange"->Fit},
PrintingCopies->1,
PrintingPageRange->{1, Automatic},
ShowCellBracket->Automatic,
CellContext->Notebook,
TrackCellChangeTimes->False,
FrontEndVersion->"11.1 for Mac OS X x86 (32-bit, 64-bit Kernel) (April 18, \
2017)",
StyleDefinitions->"Default.nb"
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
Cell[1486, 35, 100, 0, 92, "Title", "ExpressionUUID" -> \
"cf99e9d2-40ae-4844-b835-90ed36bd38f0"],
Cell[1589, 37, 169, 3, 29, "Text", "ExpressionUUID" -> \
"7e0ff946-ca94-463d-9b2f-f3765a336c14"],
Cell[1761, 42, 253, 7, 32, "Input", "ExpressionUUID" -> \
"9b20005d-057f-46c1-ac8c-1158c961d2ad"],
Cell[CellGroupData[{
Cell[2039, 53, 90, 0, 65, "Chapter", "ExpressionUUID" -> \
"e7038ba2-24ab-467f-8b12-80b64323e3c7"],
Cell[2132, 55, 181, 4, 32, "Input", "ExpressionUUID" -> \
"83938e1b-d416-4715-b97d-04e6b2b5d76e"],
Cell[2316, 61, 604, 16, 96, "Input", "ExpressionUUID" -> \
"e697d91d-9bd9-4b57-8e8a-a54c954010af"],
Cell[CellGroupData[{
Cell[2945, 81, 373, 10, 32, "Input", "ExpressionUUID" -> \
"90602f06-bf07-487a-af54-8f353306fc59"],
Cell[3321, 93, 298, 6, 54, "Output", "ExpressionUUID" -> \
"e8c334ee-b5e3-4f7e-b3bb-9c54e47e5db5"]
}, Open  ]],
Cell[CellGroupData[{
Cell[3656, 104, 423, 11, 54, "Input", "ExpressionUUID" -> \
"a32eeffe-be91-4680-ad7c-184e776ae277"],
Cell[4082, 117, 283, 5, 54, "Output", "ExpressionUUID" -> \
"39d758af-3321-43b6-a6fd-0b3ba6caf1a3"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[4414, 128, 88, 0, 65, "Chapter", "ExpressionUUID" -> \
"0cb2bf65-73db-41cc-a6ab-6ba06ab63b08"],
Cell[4505, 130, 476, 14, 32, "Input", "ExpressionUUID" -> \
"76bf8377-c98e-4d4c-82ae-e9e5dfa516f5"],
Cell[4984, 146, 288, 8, 32, "Input", "ExpressionUUID" -> \
"4561957e-a985-4844-a1f4-e9f0fc51de3b"],
Cell[5275, 156, 299, 9, 32, "Input", "ExpressionUUID" -> \
"407b2eee-cd8a-4020-beaa-0aa25c0c4fa4"],
Cell[CellGroupData[{
Cell[5599, 169, 349, 10, 54, "Input", "ExpressionUUID" -> \
"09ff462e-8ad3-44cf-b9d4-cad830757a15"],
Cell[5951, 181, 671, 19, 94, "Output", "ExpressionUUID" -> \
"dc9f75ce-61ef-48be-aa5e-bf505a51e884"]
}, Open  ]],
Cell[6637, 203, 481, 14, 32, "Input", "ExpressionUUID" -> \
"aaf6e5a4-47b3-4317-91cc-16331da9c985"]
}, Open  ]],
Cell[CellGroupData[{
Cell[7155, 222, 82, 0, 65, "Chapter", "ExpressionUUID" -> \
"4a6fc1b8-f112-4f0a-96a6-c5ccb50a4d63"],
Cell[CellGroupData[{
Cell[7262, 226, 239, 6, 75, "Input", "ExpressionUUID" -> \
"79f6ad76-2e27-4bf5-b86c-1d55b51b7247"],
Cell[7504, 234, 7437, 161, 74, "Output", "ExpressionUUID" -> \
"2f73173e-c026-4c65-afc3-52b1f743fd4d"]
}, Open  ]],
Cell[CellGroupData[{
Cell[14978, 400, 219, 5, 32, "Input", "ExpressionUUID" -> \
"77a4aa73-782b-4277-93c0-9c8edf1fe759"],
Cell[15200, 407, 1920, 48, 75, "Output", "ExpressionUUID" -> \
"d701be7c-e74f-4244-89fa-3f1846e5fa4b"]
}, Open  ]],
Cell[17135, 458, 184, 4, 32, "Input", "ExpressionUUID" -> \
"d5f5e435-19c1-4d89-a92a-66ed97002a14"],
Cell[CellGroupData[{
Cell[17344, 466, 639, 17, 75, "Input", "ExpressionUUID" -> \
"d641b70d-9faa-4d22-9eed-0becb44f5451"],
Cell[17986, 485, 132, 2, 32, "Output", "ExpressionUUID" -> \
"6fdb4d0d-5497-4dc5-a18c-dd860001112c"],
Cell[18121, 489, 981, 27, 91, "Output", "ExpressionUUID" -> \
"e25eda57-eb68-460c-9551-1b14de4eb575"]
}, Open  ]],
Cell[19117, 519, 216, 5, 32, "Input", "ExpressionUUID" -> \
"8d86c694-b066-419a-bafa-3105e5354f40"],
Cell[CellGroupData[{
Cell[19358, 528, 293, 7, 54, "Input", "ExpressionUUID" -> \
"d2f0be2d-7c20-455c-91c8-bb50c97ee4a1"],
Cell[19654, 537, 133, 2, 32, "Output", "ExpressionUUID" -> \
"b2eda962-8e3e-4aa3-a4f0-4b38697b3946"]
}, Open  ]],
Cell[CellGroupData[{
Cell[19824, 544, 285, 7, 32, "Input", "ExpressionUUID" -> \
"8f23a118-4d97-4b7a-b160-538db57df3c9"],
Cell[20112, 553, 2152, 41, 159, "Output", "ExpressionUUID" -> \
"4ac4d44c-057e-4095-b90a-ed296c877a1a"]
}, Open  ]],
Cell[22279, 597, 320, 8, 32, "Input", "ExpressionUUID" -> \
"42539ece-0f8e-482d-bf8e-767646654fed"],
Cell[22602, 607, 214, 5, 32, "Input", "ExpressionUUID" -> \
"a5d7d941-7db2-4ebb-abe1-e0a8ebff9fcf"],
Cell[22819, 614, 551, 13, 54, "Input", "ExpressionUUID" -> \
"da7b4149-96e1-4140-94dc-483f0a3366fb"],
Cell[CellGroupData[{
Cell[23395, 631, 300, 6, 32, "Input", "ExpressionUUID" -> \
"aa1ad422-2ef0-47f7-b1a2-26be6fff2818"],
Cell[23698, 639, 12108, 258, 122, "Output", "ExpressionUUID" -> \
"d60939c9-0baf-4438-b346-b594c87579b0"]
}, Open  ]]
}, Open  ]],
Cell[CellGroupData[{
Cell[35855, 903, 84, 0, 65, "Chapter", "ExpressionUUID" -> \
"c0bf0315-48c1-4aec-a0af-424fef308487"],
Cell[35942, 905, 362, 10, 54, "Input", "ExpressionUUID" -> \
"bc8160e5-2a4d-4253-8b12-53b1d23a13f1"],
Cell[CellGroupData[{
Cell[36329, 919, 434, 13, 32, "Input", "ExpressionUUID" -> \
"70cf8f14-118f-4ab2-9879-14d2271bb792"],
Cell[36766, 934, 238, 5, 35, "Output", "ExpressionUUID" -> \
"f4e72ad4-e1f2-478f-9130-54411a4d0ab0"]
}, Open  ]],
Cell[CellGroupData[{
Cell[37041, 944, 207, 5, 51, "Input", "ExpressionUUID" -> \
"c5c1b0c0-0695-4c13-97fb-0847292ebc22"],
Cell[37251, 951, 101, 0, 32, "Output", "ExpressionUUID" -> \
"7f95bc04-82c1-45d2-b19c-b83b5ea87c9f"]
}, Open  ]],
Cell[37367, 954, 155, 2, 29, "Text", "ExpressionUUID" -> \
"447b0837-bb87-4719-94db-26996375f778"],
Cell[37525, 958, 331, 8, 32, "Input", "ExpressionUUID" -> \
"7c31359d-fbc1-46ab-8cf0-a7ee4cf81d32"],
Cell[CellGroupData[{
Cell[37881, 970, 378, 9, 54, "Input", "ExpressionUUID" -> \
"45e9a75a-a6a1-4cfc-9b49-37e80f787065"],
Cell[38262, 981, 101, 0, 32, "Output", "ExpressionUUID" -> \
"1021976b-2f18-49de-b9ad-8433941b5049"]
}, Open  ]]
}, Open  ]]
}, Open  ]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature Wwp1cHPJApQ4xAKxvUTWcyDi *)
