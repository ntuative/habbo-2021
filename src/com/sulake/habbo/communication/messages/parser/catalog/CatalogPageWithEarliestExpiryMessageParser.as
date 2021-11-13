package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CatalogPageWithEarliestExpiryMessageParser implements IMessageParser 
    {

        private var _pageName:String;
        private var _secondsToExpiry:int;
        private var _image:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _pageName = _arg_1.readString();
            _secondsToExpiry = _arg_1.readInteger();
            _image = _arg_1.readString();
            return (true);
        }

        public function get pageName():String
        {
            return (_pageName);
        }

        public function get secondsToExpiry():int
        {
            return (_secondsToExpiry);
        }

        public function get image():String
        {
            return (_image);
        }


    }
}