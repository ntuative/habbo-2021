package com.sulake.habbo.navigator.domain
{
    import com.sulake.core.window.IWindowContainer;

    public class RoomLayout 
    {

        private var _requiredClubLevel:int;
        private var _tileSize:int;
        private var _name:String;
        private var _view:IWindowContainer;

        public function RoomLayout(_arg_1:int, _arg_2:int, _arg_3:String)
        {
            _requiredClubLevel = _arg_1;
            _tileSize = _arg_2;
            _name = _arg_3;
        }

        public function get requiredClubLevel():int
        {
            return (_requiredClubLevel);
        }

        public function get tileSize():int
        {
            return (_tileSize);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function set view(_arg_1:IWindowContainer):void
        {
            _view = _arg_1;
        }


    }
}