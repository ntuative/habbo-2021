package com.sulake.habbo.avatar.structure
{
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IPalette;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;

    public /*dynamic*/ interface IFigureSetData 
    {

        function getSetType(_arg_1:String):ISetType;
        function getPalette(_arg_1:int):IPalette;
        function getFigurePartSet(_arg_1:int):IFigurePartSet;

    }
}