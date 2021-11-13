package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameObjectsData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2StageStartingMessageParser implements IMessageParser 
    {

        private var _gameObjects:GameObjectsData;
        private var _gameType:int;
        private var _roomType:String;
        private var _countDown:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _gameType = _arg_1.readInteger();
            _roomType = _arg_1.readString();
            _countDown = _arg_1.readInteger();
            _gameObjects = new GameObjectsData(_arg_1);
            return (true);
        }

        public function get gameObjects():GameObjectsData
        {
            return (_gameObjects);
        }

        public function get gameType():int
        {
            return (_gameType);
        }

        public function get roomType():String
        {
            return (_roomType);
        }

        public function get countDown():int
        {
            return (_countDown);
        }


    }
}