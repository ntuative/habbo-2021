package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class EpicPopupMessageParser implements IMessageParser 
    {

        private var _imageUri:String;


        public function flush():Boolean
        {
            _imageUri = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _imageUri = _arg_1.readString();
            return (true);
        }

        public function get imageUri():String
        {
            return (_imageUri);
        }


    }
}