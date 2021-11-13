package com.sulake.habbo.communication.messages.outgoing.room.chat
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class WhisperMessageComposer implements IMessageComposer 
    {

        private var _text:String;
        private var _recipientName:String;
        private var _SafeStr_1921:int = 0;

        public function WhisperMessageComposer(_arg_1:String, _arg_2:String, _arg_3:int=0)
        {
            _recipientName = _arg_1;
            _text = _arg_2;
            _SafeStr_1921 = _arg_3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([((_recipientName + " ") + _text), _SafeStr_1921]);
        }


    }
}

