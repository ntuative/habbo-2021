package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SellablePetPaletteData 
    {

        private var _type:int;
        private var _breedId:int;
        private var _paletteId:int;
        private var _sellable:Boolean;
        private var _rare:Boolean;

        public function SellablePetPaletteData(_arg_1:IMessageDataWrapper)
        {
            _type = _arg_1.readInteger();
            _breedId = _arg_1.readInteger();
            _paletteId = _arg_1.readInteger();
            _sellable = _arg_1.readBoolean();
            _rare = _arg_1.readBoolean();
        }

        public function get type():int
        {
            return (_type);
        }

        public function get breedId():int
        {
            return (_breedId);
        }

        public function get paletteId():int
        {
            return (_paletteId);
        }

        public function get sellable():Boolean
        {
            return (_sellable);
        }

        public function get rare():Boolean
        {
            return (_rare);
        }


    }
}