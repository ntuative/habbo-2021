package com.sulake.habbo.communication.messages.parser.inventory.bots
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BotReceivedMessageParser implements IMessageParser 
    {

        private var _boughtAsGift:Boolean;
        private var _item:BotData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _boughtAsGift = _arg_1.readBoolean();
            _item = new BotData(_arg_1);
            return (true);
        }

        public function get boughtAsGift():Boolean
        {
            return (_boughtAsGift);
        }

        public function get item():BotData
        {
            return (_item);
        }


    }
}