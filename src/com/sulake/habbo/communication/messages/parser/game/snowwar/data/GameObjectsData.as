package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowWarGameObjectData;

    public class GameObjectsData 
    {

        private var _gameObjects:Array = [];

        public function GameObjectsData(_arg_1:IMessageDataWrapper)
        {
            parse(_arg_1);
        }

        public function get gameObjects():Array
        {
            return (_gameObjects);
        }

        public function parse(_arg_1:IMessageDataWrapper):void
        {
            var _local_3:int;
            var _local_5:int;
            var _local_4:int;
            var _local_6:SnowWarGameObjectData;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_5 = _arg_1.readInteger();
                _local_4 = _arg_1.readInteger();
                _local_6 = SnowWarGameObjectData.create(_local_5, _local_4);
                _local_6.parse(_arg_1);
                _gameObjects.push(_local_6);
                _local_3++;
            };
        }


    }
}