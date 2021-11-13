package com.sulake.habbo.groups
{
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.users.IGuildData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class GuildSettingsCtrl 
    {

        public static const TYPE_REGULAR:int = 0;
        public static const TYPE_EXCLUSIVE:int = 1;
        public static const _SafeStr_1853:int = 2;
        public static const TYPE_LARGE:int = 3;
        public static const _SafeStr_1854:int = 4;
        public static const RIGHTS_MEMBERS:int = 0;
        public static const _SafeStr_2649:int = 1;

        private var _SafeStr_690:GuildSettingsData;
        private var _SafeStr_1570:ISelectorWindow;
        private var _SafeStr_2650:IRadioButtonWindow;
        private var _SafeStr_2651:IRadioButtonWindow;
        private var _SafeStr_2652:IRadioButtonWindow;
        private var _SafeStr_2653:_SafeStr_108;


        public function prepare(_arg_1:IWindowContainer):void
        {
            var _local_2:IWindowContainer = (_arg_1.findChildByName("step_cont_5") as IWindowContainer);
            _SafeStr_1570 = (_local_2.findChildByName("group_type_selector") as ISelectorWindow);
            _SafeStr_2650 = (_local_2.findChildByName("rb_type_regular") as IRadioButtonWindow);
            _SafeStr_2650.procedure = onRegularGuildType;
            _SafeStr_2651 = (_local_2.findChildByName("rb_type_exclusive") as IRadioButtonWindow);
            _SafeStr_2651.procedure = onExclusiveGuildType;
            _SafeStr_2652 = (_local_2.findChildByName("rb_type_private") as IRadioButtonWindow);
            _SafeStr_2652.procedure = onPrivateGuildType;
            _SafeStr_2653 = (_local_2.findChildByName("cb_member_rights") as _SafeStr_108);
            _SafeStr_2653.procedure = onMembersHaveRights;
        }

        public function refresh(_arg_1:IGuildData):void
        {
            _SafeStr_690 = new GuildSettingsData(_arg_1);
            switch (_SafeStr_690.guildType)
            {
                case 0:
                    _SafeStr_1570.setSelected(_SafeStr_2650);
                    break;
                case 1:
                    _SafeStr_1570.setSelected(_SafeStr_2651);
                    break;
                case 2:
                    _SafeStr_1570.setSelected(_SafeStr_2652);
                    break;
                default:
                    _SafeStr_1570.setSelected(_SafeStr_2650);
            };
            if (_SafeStr_690.rightsLevel == 0)
            {
                _SafeStr_2653.select();
            }
            else
            {
                _SafeStr_2653.unselect();
            };
            _SafeStr_1570.invalidate();
        }

        private function onRegularGuildType(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WE_SELECT")
            {
                _SafeStr_690.guildType = 0;
            };
        }

        private function onExclusiveGuildType(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WE_SELECT")
            {
                _SafeStr_690.guildType = 1;
            };
        }

        private function onPrivateGuildType(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WE_SELECT")
            {
                _SafeStr_690.guildType = 2;
            };
        }

        private function onMembersHaveRights(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WE_SELECT")
            {
                _SafeStr_690.rightsLevel = 0;
            };
            if (_arg_1.type == "WE_UNSELECT")
            {
                _SafeStr_690.rightsLevel = 1;
            };
        }

        public function resetModified():void
        {
            if (((!(_SafeStr_690 == null)) && (_SafeStr_690.isModified)))
            {
                _SafeStr_690.resetModified();
            };
        }

        public function get guildType():int
        {
            return (_SafeStr_690.guildType);
        }

        public function get rightsLevel():int
        {
            return (_SafeStr_690.rightsLevel);
        }

        public function get isInitialized():Boolean
        {
            return (!(_SafeStr_690 == null));
        }


    }
}

