package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IDropMenuWindow;

    public class ActorHasHandItem extends DefaultConditionType 
    {


        override public function get code():int
        {
            return (_SafeStr_228.ACTOR_HAS_HANDITEM);
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = [];
            _local_2.push(getSelectedHandItemCode(_arg_1));
            return (_local_2);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            setSelectedHandItemByCode(_arg_1, _arg_2.intParams[0]);
        }

        private function getSelectedHandItemCode(_arg_1:IWindowContainer):int
        {
            var _local_3:Array = getDropMenu(_arg_1, "menu_handitem").enumerateSelection();
            var _local_2:int = getDropMenu(_arg_1, "menu_handitem").selection;
            if (_local_2 == -1)
            {
                return (0);
            };
            return (getCodeInHandItemLoc(_local_3[_local_2]));
        }

        private function setSelectedHandItemByCode(_arg_1:IWindowContainer, _arg_2:int):void
        {
            var _local_4:int;
            var _local_3:Array = getDropMenu(_arg_1, "menu_handitem").enumerateSelection();
            var _local_5:int = -1;
            _local_4 = 0;
            while (_local_4 < _local_3.length)
            {
                if (getCodeInHandItemLoc(_local_3[_local_4]) == _arg_2)
                {
                    _local_5 = _local_4;
                };
                _local_4++;
            };
            getDropMenu(_arg_1, "menu_handitem").selection = _local_5;
        }

        private function getCodeInHandItemLoc(_arg_1:String):int
        {
            return (parseInt(_arg_1.substr(10, (_arg_1.length - 11))));
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getDropMenu(_arg_1:IWindowContainer, _arg_2:String):IDropMenuWindow
        {
            return (IDropMenuWindow(_arg_1.findChildByName(_arg_2)));
        }


    }
}

