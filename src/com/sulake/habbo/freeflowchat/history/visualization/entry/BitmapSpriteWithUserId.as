package com.sulake.habbo.freeflowchat.history.visualization.entry
{
    import flash.display.Bitmap;

   public class BitmapSpriteWithUserId extends Bitmap
    {

        private var _userId:int;
        private var _roomId:int;
        private var _canIgnore:Boolean;
        private var _userName:String;


        public function get canIgnore():Boolean
        {
            return (_canIgnore);
        }

        public function set canIgnore(_arg_1:Boolean):void
        {
            _canIgnore = _arg_1;
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function set userName(_arg_1:String):void
        {
            _userName = _arg_1;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function set userId(_arg_1:int):void
        {
            _userId = _arg_1;
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function set roomId(_arg_1:int):void
        {
            _roomId = _arg_1;
        }


    }
}
