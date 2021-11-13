package com.sulake.habbo.game.snowwar.events
{
    import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
    import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
    import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;

    public class CreateSnowballEvent extends SnowWarGameEvent 
    {

        private var _snowBallGameObject:SnowBallGameObject;
        private var _SafeStr_2485:HumanGameObject;
        private var _SafeStr_2486:int;
        private var _SafeStr_2487:int;
        private var _SafeStr_2488:int;

        public function CreateSnowballEvent(_arg_1:int, _arg_2:HumanGameObject, _arg_3:int, _arg_4:int, _arg_5:int)
        {
            this._snowBallGameObject = new SnowBallGameObject(_arg_1);
            this._SafeStr_2485 = _arg_2;
            this._SafeStr_2486 = _arg_3;
            this._SafeStr_2487 = _arg_4;
            this._SafeStr_2488 = _arg_5;
        }

        override public function dispose():void
        {
            super.dispose();
            _snowBallGameObject = null;
            _SafeStr_2485 = null;
        }

        public function set snowBallGameObject(_arg_1:SnowBallGameObject):void
        {
            this._snowBallGameObject = _arg_1;
        }

        override public function apply(_arg_1:SynchronizedGameStage):void
        {
            _arg_1.addGameObject(_snowBallGameObject.gameObjectId, _snowBallGameObject);
            _snowBallGameObject.isActive = true;
            var _local_2:int = _SafeStr_2485.currentLocation.x;
            var _local_3:int = _SafeStr_2485.currentLocation.y;
            var _local_4:int = 3000;
            _snowBallGameObject.initialize(_local_2, _local_3, _local_4, _SafeStr_2488, _SafeStr_2486, _SafeStr_2487, _SafeStr_2485);
        }


    }
}

