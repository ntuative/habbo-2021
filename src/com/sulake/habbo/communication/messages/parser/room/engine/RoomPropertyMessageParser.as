package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomPropertyMessageParser implements IMessageParser 
    {

        private var _floorType:String = null;
        private var _wallType:String = null;
        private var _landscapeType:String = null;
        private var _animatedLandscapeType:String = null;


        public function get floorType():String
        {
            return (_floorType);
        }

        public function get wallType():String
        {
            return (_wallType);
        }

        public function get landscapeType():String
        {
            return (_landscapeType);
        }

        public function get animatedLandscapeType():String
        {
            return (_animatedLandscapeType);
        }

        public function flush():Boolean
        {
            _floorType = null;
            _wallType = null;
            _landscapeType = null;
            _animatedLandscapeType = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:String = _arg_1.readString();
            var _local_2:String = _arg_1.readString();
            switch (_local_3)
            {
                case "floor":
                    _floorType = _local_2;
                    break;
                case "wallpaper":
                    _wallType = _local_2;
                    break;
                case "landscape":
                    _landscapeType = _local_2;
                    break;
                case "landscapeanim":
                    _animatedLandscapeType = _local_2;
            };
            return (true);
        }


    }
}