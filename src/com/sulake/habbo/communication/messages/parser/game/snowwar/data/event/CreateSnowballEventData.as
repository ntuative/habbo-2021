package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CreateSnowballEventData extends SnowWarGameEventData 
    {

        private var _snowBallGameObjectId:int;
        private var _humanGameObjectId:int;
        private var _targetX:int;
        private var _targetY:int;
        private var _trajectory:int;

        public function CreateSnowballEventData(_arg_1:int)
        {
            super(_arg_1);
        }

        public function get snowBallGameObjectId():int
        {
            return (_snowBallGameObjectId);
        }

        public function get humanGameObjectId():int
        {
            return (_humanGameObjectId);
        }

        public function get targetX():int
        {
            return (_targetX);
        }

        public function get targetY():int
        {
            return (_targetY);
        }

        public function get trajectory():int
        {
            return (_trajectory);
        }

        override public function parse(_arg_1:IMessageDataWrapper):void
        {
            _snowBallGameObjectId = _arg_1.readInteger();
            _humanGameObjectId = _arg_1.readInteger();
            _targetX = _arg_1.readInteger();
            _targetY = _arg_1.readInteger();
            _trajectory = _arg_1.readInteger();
        }


    }
}