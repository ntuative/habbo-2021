package com.sulake.habbo.room.object.data
{
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObjectModelController;

    public class LegacyStuffData extends StuffDataBase implements IStuffData 
    {

        public static const FORMAT_KEY:int = 0;

        private var _SafeStr_690:String = "";


        override public function initializeFromIncomingMessage(_arg_1:IMessageDataWrapper):void
        {
            _SafeStr_690 = _arg_1.readString();
            super.initializeFromIncomingMessage(_arg_1);
        }

        override public function initializeFromRoomObjectModel(_arg_1:IRoomObjectModel):void
        {
            super.initializeFromRoomObjectModel(_arg_1);
            _SafeStr_690 = _arg_1.getString("furniture_data");
        }

        override public function writeRoomObjectModel(_arg_1:IRoomObjectModelController):void
        {
            super.writeRoomObjectModel(_arg_1);
            _arg_1.setNumber("furniture_data_format", 0);
            _arg_1.setString("furniture_data", _SafeStr_690);
        }

        override public function getLegacyString():String
        {
            return (_SafeStr_690);
        }

        public function setString(_arg_1:String):void
        {
            _SafeStr_690 = _arg_1;
        }

        override public function compare(_arg_1:IStuffData):Boolean
        {
            return (_SafeStr_690 == _arg_1.getLegacyString());
        }


    }
}

