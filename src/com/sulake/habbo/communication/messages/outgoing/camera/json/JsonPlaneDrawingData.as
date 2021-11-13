package com.sulake.habbo.communication.messages.outgoing.camera.json
{
    import __AS3__.vec.Vector;

        public class JsonPlaneDrawingData 
    {

        private var _z:Number;
        private var _cornerPoints:Vector.<JsonPoint> = new Vector.<JsonPoint>();
        private var _color:uint;
        private var _masks:Array = [];
        private var _bottomAligned:Boolean;
        private var _texCols:Array = [];


        public function get z():Number
        {
            return (_z);
        }

        public function set z(_arg_1:Number):void
        {
            _z = _arg_1;
        }

        public function get cornerPoints():Vector.<JsonPoint>
        {
            return (_cornerPoints);
        }

        public function addCornerPoint(_arg_1:int, _arg_2:int):void
        {
            _cornerPoints.push(new JsonPoint(_arg_1, _arg_2));
        }

        public function get masks():Array
        {
            return (_masks);
        }

        public function addMask(_arg_1:JsonMaskDrawingData):void
        {
            _masks.push(_arg_1);
        }

        public function get color():uint
        {
            return (_color);
        }

        public function set color(_arg_1:uint):void
        {
            _color = _arg_1;
        }

        public function get bottomAligned():Boolean
        {
            return (_bottomAligned);
        }

        public function setBottomAligned(_arg_1:Boolean):void
        {
            _bottomAligned = _arg_1;
        }

        public function get texCols():Array
        {
            return (_texCols);
        }

        public function addTexCol(_arg_1:JsonTextureColumnData):void
        {
            _texCols.push(_arg_1);
        }


    }
}