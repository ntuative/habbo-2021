package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Game2PlayerData implements IDisposable 
    {

        private var _referenceId:int;
        private var _userName:String;
        private var _figureString:String;
        private var _gender:String;
        private var _teamId:int;
        private var _isDisposed:Boolean = false;


        public function dispose():void
        {
            _userName = null;
            _figureString = null;
            _isDisposed = true;
        }

        public function get disposed():Boolean
        {
            return (_isDisposed);
        }

        public function parse(_arg_1:IMessageDataWrapper):void
        {
            _referenceId = _arg_1.readInteger();
            _userName = _arg_1.readString();
            _figureString = _arg_1.readString();
            _gender = _arg_1.readString();
            _teamId = _arg_1.readInteger();
        }

        public function toString():String
        {
            return ((("[Game Player] " + _referenceId) + ": ") + _userName);
        }

        public function get referenceId():int
        {
            return (_referenceId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get figureString():String
        {
            return (_figureString);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get teamId():int
        {
            return (_teamId);
        }

        public function get isDisposed():Boolean
        {
            return (_isDisposed);
        }


    }
}