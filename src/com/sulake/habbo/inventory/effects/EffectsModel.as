package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectActivatedComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectSelectedComposer;
    import com.sulake.habbo.inventory.IAvatarEffect;
    import com.sulake.core.window.IWindowContainer;

    public class EffectsModel implements IInventoryModel 
    {

        public static const FILTER_NONE:int = -1;
        public static const FILTER_INCLUDE_INACTIVE:int = 0;
        public static const FILTER_INCLUDE_ACTIVE:int = 1;

        private var _SafeStr_1284:HabboInventory;
        private var _SafeStr_570:EffectsView;
        private var _SafeStr_2740:Array;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _SafeStr_2741:EffectListProxy;
        private var _SafeStr_2742:EffectListProxy;
        private var _disposed:Boolean = false;
        private var _lastActivatedEffect:int = -1;

        public function EffectsModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IHabboLocalizationManager)
        {
            _SafeStr_1284 = _arg_1;
            _SafeStr_2740 = [];
            _assets = _arg_4;
            _communication = _arg_3;
            _SafeStr_2741 = new EffectListProxy(this, 1);
            _SafeStr_2742 = new EffectListProxy(this, 0);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get lastActivatedEffect():int
        {
            return (_lastActivatedEffect);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_1284 = null;
                if (_SafeStr_570 != null)
                {
                    _SafeStr_570.dispose();
                };
                if (_SafeStr_2741 != null)
                {
                    _SafeStr_2741.dispose();
                    _SafeStr_2741 = null;
                };
                if (_SafeStr_2742 != null)
                {
                    _SafeStr_2742.dispose();
                    _SafeStr_2742 = null;
                };
                _disposed = true;
            };
        }

        public function requestInitialization():void
        {
        }

        public function categorySwitch(_arg_1:String):void
        {
        }

        public function addEffect(_arg_1:Effect, _arg_2:Boolean=true):void
        {
            var _local_4:BitmapDataAsset;
            var _local_3:Effect = getEffect(_arg_1.type);
            if (_local_3 != null)
            {
                _local_3.amountInInventory++;
            }
            else
            {
                _local_4 = BitmapDataAsset(_assets.getAssetByName((("fx_icon_" + _arg_1.type) + "_png")));
                if (_local_4 != null)
                {
                    _arg_1.iconImage = BitmapData(_local_4.content);
                };
                _SafeStr_2740.push(_arg_1);
            };
            if (_arg_2)
            {
                refreshViews();
            };
        }

        private function getEffect(_arg_1:int):Effect
        {
            var _local_3:int;
            var _local_2:Effect;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2740.length)
            {
                _local_2 = _SafeStr_2740[_local_3];
                if (_local_2.type == _arg_1)
                {
                    return (_local_2);
                };
                _local_3++;
            };
            return (null);
        }

        private function removeEffect(_arg_1:int):void
        {
            var _local_3:int;
            var _local_2:Effect;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2740.length)
            {
                _local_2 = _SafeStr_2740[_local_3];
                if (_local_2.type == _arg_1)
                {
                    _SafeStr_2740.splice(_local_3, 1);
                    refreshViews();
                    return;
                };
                _local_3++;
            };
        }

        public function refreshViews():void
        {
            if (_SafeStr_570)
            {
                _SafeStr_570.updateListViews();
                _SafeStr_570.updateActionView();
            };
        }

        public function requestEffectActivated(_arg_1:int):void
        {
            _SafeStr_1284.communication.connection.send(new AvatarEffectActivatedComposer(_arg_1));
        }

        public function setEffectActivated(_arg_1:int):void
        {
            var _local_2:Effect = getEffect(_arg_1);
            if (_local_2 != null)
            {
                stopUsingAllEffects(false, false);
                _local_2.isActive = true;
                _local_2.isInUse = true;
                refreshViews();
            };
        }

        public function useEffect(_arg_1:int):void
        {
            stopUsingAllEffects(false, false, true);
            var _local_2:Effect = getEffect(_arg_1);
            if (_local_2 == null)
            {
                return;
            };
            if (!_local_2.isActive)
            {
                requestEffectActivated(_local_2.type);
            };
            if (_local_2.isInUse == false)
            {
                _local_2.isInUse = true;
                _SafeStr_1284.communication.connection.send(new AvatarEffectSelectedComposer(_arg_1));
                _lastActivatedEffect = _arg_1;
                refreshViews();
            };
        }

        public function stopUsingEffect(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_3:Effect = getEffect(_arg_1);
            if (_local_3 != null)
            {
                if (_local_3.isInUse == true)
                {
                    _local_3.isInUse = false;
                    if (_arg_2)
                    {
                        _SafeStr_1284.communication.connection.send(new AvatarEffectSelectedComposer(-1));
                        _lastActivatedEffect = -1;
                    };
                    refreshViews();
                };
            };
        }

        public function stopUsingAllEffects(_arg_1:Boolean=true, _arg_2:Boolean=true, _arg_3:Boolean=false):void
        {
            var _local_5:int;
            var _local_4:Effect;
            _local_5 = 0;
            while (_local_5 < _SafeStr_2740.length)
            {
                _local_4 = _SafeStr_2740[_local_5];
                _local_4.isInUse = false;
                _local_5++;
            };
            if (_arg_1)
            {
                _SafeStr_1284.communication.connection.send(new AvatarEffectSelectedComposer(-1));
            };
            if (_arg_2)
            {
                refreshViews();
            };
            if (_arg_3)
            {
                _lastActivatedEffect = -1;
            };
        }

        public function toggleEffectSelected(_arg_1:int):void
        {
            var _local_2:Effect = getEffect(_arg_1);
            if (_local_2 != null)
            {
                if (_local_2.isSelected)
                {
                    setEffectDeselected(_arg_1);
                }
                else
                {
                    setEffectSelected(_arg_1);
                };
                refreshViews();
            };
        }

        public function getEffectInterface(_arg_1:int):IAvatarEffect
        {
            return (getEffect(_arg_1) as IAvatarEffect);
        }

        public function setEffectSelected(_arg_1:int):void
        {
            var _local_2:Effect = getEffect(_arg_1);
            if (_local_2 != null)
            {
                setAllEffectsDeselected(false);
                _local_2.isSelected = true;
                refreshViews();
            };
        }

        public function setEffectDeselected(_arg_1:int):void
        {
            var _local_2:Effect = getEffect(_arg_1);
            if (_local_2 != null)
            {
                _local_2.isSelected = false;
                refreshViews();
            };
        }

        private function setAllEffectsDeselected(_arg_1:Boolean=true):void
        {
            var _local_3:int;
            var _local_2:Effect;
            _local_3 = 0;
            while (_local_3 < _SafeStr_2740.length)
            {
                _local_2 = _SafeStr_2740[_local_3];
                _local_2.isSelected = false;
                _local_3++;
            };
            if (_arg_1)
            {
                refreshViews();
            };
        }

        public function getSelectedEffect(_arg_1:int=-1):Effect
        {
            var _local_4:int;
            var _local_3:Effect;
            var _local_2:Array = getEffects(_arg_1);
            _local_4 = 0;
            while (_local_4 < _local_2.length)
            {
                _local_3 = _local_2[_local_4];
                if (_local_3.isSelected)
                {
                    return (_local_3);
                };
                _local_4++;
            };
            return (null);
        }

        public function getEffects(_arg_1:int=-1):Array
        {
            var _local_4:int;
            var _local_3:Effect;
            var _local_2:Array = [];
            _local_4 = 0;
            while (_local_4 < _SafeStr_2740.length)
            {
                _local_3 = _SafeStr_2740[_local_4];
                if (((((_local_3.isActive) && (_arg_1 == 1)) || ((!(_local_3.isActive)) && (_arg_1 == 0))) || (_arg_1 == -1)))
                {
                    _local_2.push(_local_3);
                };
                _local_4++;
            };
            return (_local_2);
        }

        public function setEffectExpired(_arg_1:int):void
        {
            _lastActivatedEffect = -1;
            var _local_2:Effect = getEffect(_arg_1);
            if (_local_2 != null)
            {
                if (_local_2.amountInInventory > 1)
                {
                    _local_2.setOneEffectExpired();
                    refreshViews();
                }
                else
                {
                    removeEffect(_local_2.type);
                };
            };
        }

        public function getItemInIndex(_arg_1:int, _arg_2:int=-1):Effect
        {
            var _local_3:Array = getEffects(_arg_2);
            if (((_arg_1 < 0) || (_arg_1 >= _local_3.length)))
            {
                return (null);
            };
            var _local_4:Effect = _local_3[_arg_1];
            return (_local_4);
        }

        public function getWindowContainer():IWindowContainer
        {
            return ((_SafeStr_570) ? _SafeStr_570.getWindowContainer() : null);
        }

        public function closingInventoryView():void
        {
        }

        public function subCategorySwitch(_arg_1:String):void
        {
        }

        public function reactivateLastEffect():void
        {
            if (_lastActivatedEffect != -1)
            {
                useEffect(_lastActivatedEffect);
            };
        }

        public function updateView():void
        {
            if (((_SafeStr_570) && (!(_SafeStr_570.disposed))))
            {
                _SafeStr_570.updateListViews();
                _SafeStr_570.updateActionView();
            };
        }

        public function selectItemById(_arg_1:String):void
        {
            setEffectSelected(int(_arg_1));
        }


    }
}

