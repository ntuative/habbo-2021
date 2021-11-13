package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SellablePetPalettesParser implements IMessageParser 
    {

        private var _productCode:String = "";
        private var _SafeStr_1539:Array = [];


        public function get productCode():String
        {
            return (_productCode);
        }

        public function get sellablePalettes():Array
        {
            return (_SafeStr_1539.slice());
        }

        public function flush():Boolean
        {
            _productCode = "";
            _SafeStr_1539 = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _productCode = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _SafeStr_1539.push(new SellablePetPaletteData(_arg_1));
                _local_3++;
            };
            return (true);
        }


    }
}

