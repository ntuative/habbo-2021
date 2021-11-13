package com.sulake.habbo.communication.messages.parser.campaign
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CampaignCalendarDoorOpenedMessageParser implements IMessageParser 
    {

        private var _doorOpened:Boolean;
        private var _productName:String;
        private var _customImage:String;
        private var _furnitureClassName:String;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _doorOpened = _arg_1.readBoolean();
            _productName = _arg_1.readString();
            _customImage = _arg_1.readString();
            _furnitureClassName = _arg_1.readString();
            return (true);
        }

        public function flush():Boolean
        {
            _doorOpened = false;
            _productName = null;
            _customImage = null;
            _furnitureClassName = null;
            return (true);
        }

        public function get doorOpened():Boolean
        {
            return (_doorOpened);
        }

        public function get productName():String
        {
            return (_productName);
        }

        public function get customImage():String
        {
            return (_customImage);
        }

        public function get furnitureClassName():String
        {
            return (_furnitureClassName);
        }


    }
}