package com.sulake.habbo.friendlist
{
    public class _SafeStr_99 
    {


        public function getSelectedEntryBgColor():uint
        {
            return (4282169599);
        }

        public function getFriendTextColor(_arg_1:Boolean):uint
        {
            return ((_arg_1) ? 0xFFFFFFFF : 0xFF000000);
        }

        public function getTabFooterTextColor(_arg_1:Boolean):uint
        {
            return ((_arg_1) ? 4293848814 : 4289900703);
        }

        public function getRowShadingColor(_arg_1:int, _arg_2:Boolean):uint
        {
            if (_arg_1 == 1)
            {
                return ((_arg_2) ? 0xFFFFFFFF : 4293848814);
            };
            if (_arg_1 == 2)
            {
                return ((_arg_2) ? 0xFFFFFFFF : 4293848814);
            };
            return ((_arg_2) ? 4290164406 : 4288651167);
        }

        public function getTabTextColor(_arg_1:Boolean, _arg_2:int):uint
        {
            if (_arg_1)
            {
                return (0xFFFFFFFF);
            };
            if (_arg_2 == 1)
            {
                return (0xFF000000);
            };
            if (_arg_2 == 2)
            {
                return (4294375158);
            };
            return (4293914607);
        }

        public function getTabBgColor(_arg_1:int):uint
        {
            if (_arg_1 == 1)
            {
                return (0xFFFFFFFF);
            };
            if (_arg_1 == 2)
            {
                return (0xFFFFFFFF);
            };
            return (4290164406);
        }


    }
}

