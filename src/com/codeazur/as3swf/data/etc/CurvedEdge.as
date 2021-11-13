package com.codeazur.as3swf.data.etc
{
    import flash.geom.Point;

    public class CurvedEdge extends StraightEdge implements IEdge 
    {

        protected var _SafeStr_679:Point;

        public function CurvedEdge(_arg_1:Point, _arg_2:Point, _arg_3:Point, _arg_4:uint=0, _arg_5:uint=0)
        {
            super(_arg_1, _arg_3, _arg_4, _arg_5);
            _SafeStr_679 = _arg_2;
        }

        public function get control():Point
        {
            return (_SafeStr_679);
        }

        override public function reverseWithNewFillStyle(_arg_1:uint):IEdge
        {
            return (new CurvedEdge(to, control, from, lineStyleIdx, _arg_1));
        }

        override public function toString():String
        {
            return ((((((((("stroke:" + lineStyleIdx) + ", fill:") + fillStyleIdx) + ", start:") + from.toString()) + ", control:") + control.toString()) + ", end:") + to.toString());
        }


    }
}

