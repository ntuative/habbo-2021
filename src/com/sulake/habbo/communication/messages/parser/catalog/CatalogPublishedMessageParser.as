package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CatalogPublishedMessageParser implements IMessageParser 
    {

        private var _instantlyRefreshCatalogue:Boolean;
        private var _newFurniDataHash:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _instantlyRefreshCatalogue = _arg_1.readBoolean();
            if (_arg_1.bytesAvailable)
            {
                _newFurniDataHash = _arg_1.readString();
            };
            return (true);
        }

        public function get instantlyRefreshCatalogue():Boolean
        {
            return (_instantlyRefreshCatalogue);
        }

        public function get newFurniDataHash():String
        {
            return (_newFurniDataHash);
        }


    }
}