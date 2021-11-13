package com.sulake.habbo.communication.messages.parser.inventory.bots
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BotAddedToInventoryParser implements IMessageParser 
    {

        private var _item:BotData;
        private var _SafeStr_2055:Boolean;


        public function flush():Boolean
        {
            _item = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _item = new BotData(_arg_1);
            _SafeStr_2055 = _arg_1.readBoolean();
            return (true);
        }

        public function get item():BotData
        {
            return (_item);
        }

        public function openInventory():Boolean
        {
            return (_SafeStr_2055);
        }


    }
}

