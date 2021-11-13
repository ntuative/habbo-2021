package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class OpenPetPackageRequestedMessageParser implements IMessageParser 
    {

        private var _objectId:int = -1;
        private var _figureData:PetFigureData;


        public function get objectId():int
        {
            return (_objectId);
        }

        public function get figureData():PetFigureData
        {
            return (_figureData);
        }

        public function flush():Boolean
        {
            _objectId = -1;
            _figureData = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _objectId = _arg_1.readInteger();
            if (!_arg_1.bytesAvailable)
            {
                return (true);
            };
            _figureData = new PetFigureData(_arg_1);
            return (true);
        }


    }
}