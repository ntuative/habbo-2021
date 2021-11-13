package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomVisualizationSettingsParser implements IMessageParser 
    {

        private var _wallsHidden:Boolean = false;
        private var _wallThicknessMultiplier:Number = 1;
        private var _floorThicknessMultiplier:Number = 1;


        public function get wallsHidden():Boolean
        {
            return (_wallsHidden);
        }

        public function get wallThicknessMultiplier():Number
        {
            return (_wallThicknessMultiplier);
        }

        public function get floorThicknessMultiplier():Number
        {
            return (_floorThicknessMultiplier);
        }

        public function flush():Boolean
        {
            _wallsHidden = false;
            _wallThicknessMultiplier = 1;
            _floorThicknessMultiplier = 1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _wallsHidden = _arg_1.readBoolean();
            var _local_3:int = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            if (_local_3 < -2)
            {
                _local_3 = -2;
            }
            else
            {
                if (_local_3 > 1)
                {
                    _local_3 = 1;
                };
            };
            if (_local_2 < -2)
            {
                _local_2 = -2;
            }
            else
            {
                if (_local_2 > 1)
                {
                    _local_2 = 1;
                };
            };
            _wallThicknessMultiplier = Math.pow(2, _local_3);
            _floorThicknessMultiplier = Math.pow(2, _local_2);
            return (true);
        }


    }
}