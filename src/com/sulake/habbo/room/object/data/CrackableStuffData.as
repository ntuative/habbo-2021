package com.sulake.habbo.room.object.data
{
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.object.IRoomObjectModel;

    public class CrackableStuffData extends StuffDataBase implements IStuffData 
    {

        public static const FORMAT_KEY:int = 7;
        private static const INTERNAL_STATE_KEY:String = "furniture_crackable_state";
        private static const INTERNAL_HIT_KEY:String = "furniture_crackable_hits";
        private static const INTERNAL_TARGET_KEY:String = "furniture_crackable_target";

        private var _SafeStr_448:String = "";
        private var _hits:int;
        private var _target:int;


        override public function initializeFromIncomingMessage(_arg_1:IMessageDataWrapper):void
        {
            _SafeStr_448 = _arg_1.readString();
            _hits = _arg_1.readInteger();
            _target = _arg_1.readInteger();
            super.initializeFromIncomingMessage(_arg_1);
        }

        override public function writeRoomObjectModel(_arg_1:IRoomObjectModelController):void
        {
            super.writeRoomObjectModel(_arg_1);
            _arg_1.setNumber("furniture_data_format", 7);
            _arg_1.setString("furniture_crackable_state", _SafeStr_448);
            _arg_1.setNumber("furniture_crackable_hits", _hits);
            _arg_1.setNumber("furniture_crackable_target", _target);
        }

        override public function initializeFromRoomObjectModel(_arg_1:IRoomObjectModel):void
        {
            super.initializeFromRoomObjectModel(_arg_1);
            _SafeStr_448 = _arg_1.getString("furniture_crackable_state");
            _hits = _arg_1.getNumber("furniture_crackable_hits");
            _target = _arg_1.getNumber("furniture_crackable_target");
        }

        override public function getLegacyString():String
        {
            return (_SafeStr_448);
        }

        public function setString(_arg_1:String):void
        {
            _SafeStr_448 = _arg_1;
        }

        public function get hits():int
        {
            return (_hits);
        }

        public function get target():int
        {
            return (_target);
        }

        override public function compare(_arg_1:IStuffData):Boolean
        {
            return (true);
        }


    }
}

