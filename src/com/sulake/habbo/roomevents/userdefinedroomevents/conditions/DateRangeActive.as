package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.globalization.DateTimeFormatter;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class DateRangeActive extends DefaultConditionType 
    {


        private static function getDate(_arg_1:IWindowContainer, _arg_2:String):Number
        {
            return (Date.parse(ITextFieldWindow(_arg_1.findChildByName(_arg_2)).text));
        }


        override public function get code():int
        {
            return (_SafeStr_228.DATE_RANGE_ACTIVE);
        }

        override public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_3:Number;
            var _local_2:Array = [];
            var _local_4:Number = getDate(_arg_1, "start_date");
            if (!isNaN(_local_4))
            {
                _local_2.push(int((_local_4 / 1000)));
                _local_3 = getDate(_arg_1, "end_date");
                if (!isNaN(_local_3))
                {
                    _local_2.push(int((_local_3 / 1000)));
                };
            };
            return (_local_2);
        }

        override public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_5:Date;
            var _local_3:Date;
            var _local_4:DateTimeFormatter = new DateTimeFormatter("en-US");
            _local_4.setDateTimePattern("yyyy/MM/dd HH:mm");
            if (_arg_2.intParams.length > 0)
            {
                _local_5 = new Date((_arg_2.intParams[0] * 1000));
                ITextFieldWindow(_arg_1.findChildByName("start_date")).text = _local_4.format(_local_5);
            }
            else
            {
                ITextFieldWindow(_arg_1.findChildByName("start_date")).text = "";
            };
            if (_arg_2.intParams.length > 1)
            {
                _local_3 = new Date((_arg_2.intParams[1] * 1000));
                ITextFieldWindow(_arg_1.findChildByName("end_date")).text = _local_4.format(_local_3);
            }
            else
            {
                ITextFieldWindow(_arg_1.findChildByName("end_date")).text = "";
            };
        }

        override public function get hasSpecialInputs():Boolean
        {
            return (true);
        }


    }
}

