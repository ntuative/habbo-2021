package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CatalogIndexMessageParser implements IMessageParser 
    {

        private var _root:NodeData;
        private var _newAdditionsAvailable:Boolean;
        private var _catalogType:String;


        public function get root():NodeData
        {
            return (_root);
        }

        public function get newAdditionsAvailable():Boolean
        {
            return (_newAdditionsAvailable);
        }

        public function get catalogType():String
        {
            return (_catalogType);
        }

        public function flush():Boolean
        {
            _root = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _root = new NodeData(_arg_1);
            _newAdditionsAvailable = _arg_1.readBoolean();
            _catalogType = _arg_1.readString();
            return (true);
        }


    }
}