package com.sulake.habbo.communication.messages.outgoing.camera.json
{
        public class JsonPoint 
    {

        private var _x:int;
        private var _y:int;

        public function JsonPoint(_arg_1:int, _arg_2:int)
        {
            this._x = _arg_1;
            this._y = _arg_2;
        }

        public function get x():int
        {
            return (_x);
        }

        public function get y():int
        {
            return (_y);
        }


    }
}