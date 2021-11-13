package com.sulake.habbo.communication.messages.outgoing.camera.json
{
        public class JsonMaskDrawingData 
    {

        private var _name:String;
        private var _location:JsonPoint;
        private var _flipH:Boolean;
        private var _flipV:Boolean;

        public function JsonMaskDrawingData(_arg_1:String, _arg_2:JsonPoint, _arg_3:Boolean, _arg_4:Boolean)
        {
            this._name = _arg_1;
            this._location = _arg_2;
            this._flipH = _arg_3;
            this._flipV = _arg_4;
        }

        public function get name():String
        {
            return (_name);
        }

        public function get location():JsonPoint
        {
            return (_location);
        }

        public function get flipH():Boolean
        {
            return (_flipH);
        }

        public function get flipV():Boolean
        {
            return (_flipV);
        }


    }
}