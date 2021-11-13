package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GameLevelData 
    {

        private var _width:int;
        private var _height:int;
        private var _heightMap:String;
        private var _fuseObjects:Array = [];

        public function GameLevelData(_arg_1:IMessageDataWrapper)
        {
            parse(_arg_1);
        }

        public function get width():int
        {
            return (_width);
        }

        public function get height():int
        {
            return (_height);
        }

        public function get heightMap():String
        {
            return (_heightMap);
        }

        public function get fuseObjects():Array
        {
            return (_fuseObjects);
        }

        public function parse(_arg_1:IMessageDataWrapper):void
        {
            var _local_3:int;
            var _local_4:FuseObjectData;
            _width = _arg_1.readInteger();
            _height = _arg_1.readInteger();
            _heightMap = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = new FuseObjectData();
                _local_4.parse(_arg_1);
                _fuseObjects.push(_local_4);
                _local_3++;
            };
        }


    }
}