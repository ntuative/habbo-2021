package com.sulake.habbo.ui.widget.chatinput.styleselector
{
    import flash.display.BitmapData;

    public class ChatStyleGridEntry 
    {

        private var _id:int;
        private var _bitmap:BitmapData;

        public function ChatStyleGridEntry(_arg_1:int, _arg_2:BitmapData)
        {
            _id = _arg_1;
            _bitmap = _arg_2;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get bitmap():BitmapData
        {
            return (_bitmap);
        }


    }
}