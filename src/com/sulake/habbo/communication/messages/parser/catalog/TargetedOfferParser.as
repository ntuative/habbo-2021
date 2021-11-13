package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TargetedOfferParser implements IMessageParser 
    {

        private var _data:TargetedOfferData;


        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new TargetedOfferData().parse(_arg_1);
            return (true);
        }

        public function get data():TargetedOfferData
        {
            return (_data);
        }


    }
}