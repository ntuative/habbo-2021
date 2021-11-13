package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.habbo.inventory.IThumbListDrawableItem;
    import com.sulake.habbo.avatar.IHabboAvatarEditorAvatarEffect;
    import com.sulake.habbo.inventory.IAvatarEffect;
    import flash.display.BitmapData;

    public class Effect implements IWidgetAvatarEffect, IThumbListDrawableItem, IHabboAvatarEditorAvatarEffect, IAvatarEffect 
    {

        private var _type:int;
        private var _subType:int;
        private var _duration:int;
        private var _amountInInventory:int = 1;
        private var _SafeStr_2738:int;
        private var _isPermanent:Boolean = false;
        private var _isActive:Boolean = false;
        private var _isSelected:Boolean = false;
        private var _isInUse:Boolean = false;
        private var _iconImage:BitmapData;
        private var _SafeStr_2739:Date;


        public function get type():int
        {
            return (_type);
        }

        public function get subType():int
        {
            return (_subType);
        }

        public function get duration():int
        {
            return (_duration);
        }

        public function get amountInInventory():int
        {
            return (_amountInInventory);
        }

        public function get isPermanent():Boolean
        {
            return (_isPermanent);
        }

        public function get isActive():Boolean
        {
            return (_isActive);
        }

        public function get isInUse():Boolean
        {
            return (_isInUse);
        }

        public function get isSelected():Boolean
        {
            return (_isSelected);
        }

        public function get icon():BitmapData
        {
            return (_iconImage);
        }

        public function get iconImage():BitmapData
        {
            return (_iconImage);
        }

        public function get secondsLeft():int
        {
            var _local_1:int;
            if (_isActive)
            {
                _local_1 = int((_SafeStr_2738 - ((new Date().valueOf() - _SafeStr_2739.valueOf()) / 1000)));
                _local_1 = Math.floor(_local_1);
                if (_local_1 < 0)
                {
                    _local_1 = 0;
                };
                return (_local_1);
            };
            return (_SafeStr_2738);
        }

        public function set type(_arg_1:int):void
        {
            _type = _arg_1;
        }

        public function set subType(_arg_1:int):void
        {
            _subType = _arg_1;
        }

        public function set duration(_arg_1:int):void
        {
            _duration = _arg_1;
        }

        public function set secondsLeft(_arg_1:int):void
        {
            _SafeStr_2738 = _arg_1;
        }

        public function set isPermanent(_arg_1:Boolean):void
        {
            _isPermanent = _arg_1;
        }

        public function set isSelected(_arg_1:Boolean):void
        {
            _isSelected = _arg_1;
        }

        public function set isInUse(_arg_1:Boolean):void
        {
            _isInUse = _arg_1;
        }

        public function set iconImage(_arg_1:BitmapData):void
        {
            _iconImage = _arg_1;
        }

        public function set amountInInventory(_arg_1:int):void
        {
            _amountInInventory = _arg_1;
        }

        public function set isActive(_arg_1:Boolean):void
        {
            if (((_arg_1) && (!(_isActive))))
            {
                _SafeStr_2739 = new Date();
            };
            _isActive = _arg_1;
        }

        public function setOneEffectExpired():void
        {
            _amountInInventory--;
            if (_amountInInventory < 0)
            {
                _amountInInventory = 0;
            };
            _SafeStr_2738 = _duration;
            _isActive = false;
            _isInUse = false;
        }


    }
}

