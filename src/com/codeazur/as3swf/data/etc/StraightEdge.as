package com.codeazur.as3swf.data.etc
{
    import flash.geom.Point;

    public class StraightEdge implements IEdge 
    {

        protected var _SafeStr_694:Point;
        protected var _SafeStr_695:Point;
        protected var _SafeStr_696:uint = 0;
        protected var _SafeStr_697:uint = 0;

        public function StraightEdge(_arg_1:Point, _arg_2:Point, _arg_3:uint=0, _arg_4:uint=0)
        {
            _SafeStr_694 = _arg_1;
            _SafeStr_695 = _arg_2;
            _SafeStr_696 = _arg_3;
            _SafeStr_697 = _arg_4;
        }

        public function get from():Point
        {
            return (_SafeStr_694);
        }

        public function get to():Point
        {
            return (_SafeStr_695);
        }

        public function get lineStyleIdx():uint
        {
            return (_SafeStr_696);
        }

        public function get fillStyleIdx():uint
        {
            return (_SafeStr_697);
        }

        public function reverseWithNewFillStyle(_arg_1:uint):IEdge
        {
            return (new StraightEdge(to, from, lineStyleIdx, _arg_1));
        }

        public function toString():String
        {
            return ((((((("stroke:" + lineStyleIdx) + ", fill:") + fillStyleIdx) + ", start:") + from.toString()) + ", end:") + to.toString());
        }


    }
}

