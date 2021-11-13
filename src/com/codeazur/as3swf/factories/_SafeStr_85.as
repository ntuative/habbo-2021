package com.codeazur.as3swf.factories
{
    import com.codeazur.as3swf.data.actions.swf3.ActionNextFrame;
    import com.codeazur.as3swf.data.actions.swf3.ActionPreviousFrame;
    import com.codeazur.as3swf.data.actions.swf3.ActionPlay;
    import com.codeazur.as3swf.data.actions.swf3.ActionStop;
    import com.codeazur.as3swf.data.actions.swf3.ActionToggleQuality;
    import com.codeazur.as3swf.data.actions.swf3.ActionStopSounds;
    import com.codeazur.as3swf.data.actions.swf4.ActionAdd;
    import com.codeazur.as3swf.data.actions.swf4.ActionSubtract;
    import com.codeazur.as3swf.data.actions.swf4.ActionMultiply;
    import com.codeazur.as3swf.data.actions.swf4.ActionDivide;
    import com.codeazur.as3swf.data.actions.swf4.ActionEquals;
    import com.codeazur.as3swf.data.actions.swf4.ActionLess;
    import com.codeazur.as3swf.data.actions.swf4.ActionAnd;
    import com.codeazur.as3swf.data.actions.swf4.ActionOr;
    import com.codeazur.as3swf.data.actions.swf4.ActionNot;
    import com.codeazur.as3swf.data.actions.swf4.ActionStringEquals;
    import com.codeazur.as3swf.data.actions.swf4.ActionStringLength;
    import com.codeazur.as3swf.data.actions.swf4.ActionStringExtract;
    import com.codeazur.as3swf.data.actions.swf4.ActionPop;
    import com.codeazur.as3swf.data.actions.swf4.ActionToInteger;
    import com.codeazur.as3swf.data.actions.swf4.ActionGetVariable;
    import com.codeazur.as3swf.data.actions.swf4.ActionSetVariable;
    import com.codeazur.as3swf.data.actions.swf4.ActionSetTarget2;
    import com.codeazur.as3swf.data.actions.swf4.ActionStringAdd;
    import com.codeazur.as3swf.data.actions.swf4.ActionGetProperty;
    import com.codeazur.as3swf.data.actions.swf4.ActionSetProperty;
    import com.codeazur.as3swf.data.actions.swf4.ActionCloneSprite;
    import com.codeazur.as3swf.data.actions.swf4.ActionRemoveSprite;
    import com.codeazur.as3swf.data.actions.swf4.ActionTrace;
    import com.codeazur.as3swf.data.actions.swf4.ActionStartDrag;
    import com.codeazur.as3swf.data.actions.swf4.ActionEndDrag;
    import com.codeazur.as3swf.data.actions.swf4.ActionStringLess;
    import com.codeazur.as3swf.data.actions.swf7.ActionThrow;
    import com.codeazur.as3swf.data.actions.swf7.ActionCastOp;
    import com.codeazur.as3swf.data.actions.swf7.ActionImplementsOp;
    import com.codeazur.as3swf.data.actions.swf4.ActionRandomNumber;
    import com.codeazur.as3swf.data.actions.swf4.ActionMBStringLength;
    import com.codeazur.as3swf.data.actions.swf4.ActionCharToAscii;
    import com.codeazur.as3swf.data.actions.swf4.ActionAsciiToChar;
    import com.codeazur.as3swf.data.actions.swf4.ActionGetTime;
    import com.codeazur.as3swf.data.actions.swf4.ActionMBStringExtract;
    import com.codeazur.as3swf.data.actions.swf4.ActionMBCharToAscii;
    import com.codeazur.as3swf.data.actions.swf4.ActionMBAsciiToChar;
    import com.codeazur.as3swf.data.actions.swf5.ActionDelete;
    import com.codeazur.as3swf.data.actions.swf5.ActionDelete2;
    import com.codeazur.as3swf.data.actions.swf5.ActionDefineLocal;
    import com.codeazur.as3swf.data.actions.swf5.ActionCallFunction;
    import com.codeazur.as3swf.data.actions.swf5.ActionReturn;
    import com.codeazur.as3swf.data.actions.swf5.ActionModulo;
    import com.codeazur.as3swf.data.actions.swf5.ActionNewObject;
    import com.codeazur.as3swf.data.actions.swf5.ActionDefineLocal2;
    import com.codeazur.as3swf.data.actions.swf5.ActionInitArray;
    import com.codeazur.as3swf.data.actions.swf5.ActionInitObject;
    import com.codeazur.as3swf.data.actions.swf5.ActionTypeOf;
    import com.codeazur.as3swf.data.actions.swf5.ActionTargetPath;
    import com.codeazur.as3swf.data.actions.swf5.ActionEnumerate;
    import com.codeazur.as3swf.data.actions.swf5.ActionAdd2;
    import com.codeazur.as3swf.data.actions.swf5.ActionLess2;
    import com.codeazur.as3swf.data.actions.swf5.ActionEquals2;
    import com.codeazur.as3swf.data.actions.swf5.ActionToNumber;
    import com.codeazur.as3swf.data.actions.swf5.ActionToString;
    import com.codeazur.as3swf.data.actions.swf5.ActionPushDuplicate;
    import com.codeazur.as3swf.data.actions.swf5.ActionStackSwap;
    import com.codeazur.as3swf.data.actions.swf5.ActionGetMember;
    import com.codeazur.as3swf.data.actions.swf5.ActionSetMember;
    import com.codeazur.as3swf.data.actions.swf5.ActionIncrement;
    import com.codeazur.as3swf.data.actions.swf5.ActionDecrement;
    import com.codeazur.as3swf.data.actions.swf5.ActionCallMethod;
    import com.codeazur.as3swf.data.actions.swf5.ActionNewMethod;
    import com.codeazur.as3swf.data.actions.swf6.ActionInstanceOf;
    import com.codeazur.as3swf.data.actions.swf6.ActionEnumerate2;
    import com.codeazur.as3swf.data.actions.swf5.ActionBitAnd;
    import com.codeazur.as3swf.data.actions.swf5.ActionBitOr;
    import com.codeazur.as3swf.data.actions.swf5.ActionBitXor;
    import com.codeazur.as3swf.data.actions.swf5.ActionBitLShift;
    import com.codeazur.as3swf.data.actions.swf5.ActionBitRShift;
    import com.codeazur.as3swf.data.actions.swf5.ActionBitURShift;
    import com.codeazur.as3swf.data.actions.swf6.ActionStrictEquals;
    import com.codeazur.as3swf.data.actions.swf6.ActionGreater;
    import com.codeazur.as3swf.data.actions.swf6.ActionStringGreater;
    import com.codeazur.as3swf.data.actions.swf7.ActionExtends;
    import com.codeazur.as3swf.data.actions.swf3.ActionGotoFrame;
    import com.codeazur.as3swf.data.actions.swf3.ActionGetURL;
    import com.codeazur.as3swf.data.actions.swf5.ActionStoreRegister;
    import com.codeazur.as3swf.data.actions.swf5.ActionConstantPool;
    import com.codeazur.as3swf.data.actions.swf3.ActionWaitForFrame;
    import com.codeazur.as3swf.data.actions.swf3.ActionSetTarget;
    import com.codeazur.as3swf.data.actions.swf3.ActionGotoLabel;
    import com.codeazur.as3swf.data.actions.swf4.ActionWaitForFrame2;
    import com.codeazur.as3swf.data.actions.swf7.ActionDefineFunction2;
    import com.codeazur.as3swf.data.actions.swf7.ActionTry;
    import com.codeazur.as3swf.data.actions.swf5.ActionWith;
    import com.codeazur.as3swf.data.actions.swf4.ActionPush;
    import com.codeazur.as3swf.data.actions.swf4.ActionJump;
    import com.codeazur.as3swf.data.actions.swf4.ActionGetURL2;
    import com.codeazur.as3swf.data.actions.swf5.ActionDefineFunction;
    import com.codeazur.as3swf.data.actions.swf4.ActionIf;
    import com.codeazur.as3swf.data.actions.swf4.ActionCall;
    import com.codeazur.as3swf.data.actions.swf4.ActionGotoFrame2;
    import com.codeazur.as3swf.data.actions.ActionUnknown;
    import com.codeazur.as3swf.data.actions.IAction;

    public class _SafeStr_85 
    {


        public static function create(_arg_1:uint, _arg_2:uint):IAction
        {
            switch (_arg_1)
            {
                case 4:
                    return (new ActionNextFrame(_arg_1, _arg_2));
                case 5:
                    return (new ActionPreviousFrame(_arg_1, _arg_2));
                case 6:
                    return (new ActionPlay(_arg_1, _arg_2));
                case 7:
                    return (new ActionStop(_arg_1, _arg_2));
                case 8:
                    return (new ActionToggleQuality(_arg_1, _arg_2));
                case 9:
                    return (new ActionStopSounds(_arg_1, _arg_2));
                case 10:
                    return (new ActionAdd(_arg_1, _arg_2));
                case 11:
                    return (new ActionSubtract(_arg_1, _arg_2));
                case 12:
                    return (new ActionMultiply(_arg_1, _arg_2));
                case 13:
                    return (new ActionDivide(_arg_1, _arg_2));
                case 14:
                    return (new ActionEquals(_arg_1, _arg_2));
                case 15:
                    return (new ActionLess(_arg_1, _arg_2));
                case 16:
                    return (new ActionAnd(_arg_1, _arg_2));
                case 17:
                    return (new ActionOr(_arg_1, _arg_2));
                case 18:
                    return (new ActionNot(_arg_1, _arg_2));
                case 19:
                    return (new ActionStringEquals(_arg_1, _arg_2));
                case 20:
                    return (new ActionStringLength(_arg_1, _arg_2));
                case 21:
                    return (new ActionStringExtract(_arg_1, _arg_2));
                case 23:
                    return (new ActionPop(_arg_1, _arg_2));
                case 24:
                    return (new ActionToInteger(_arg_1, _arg_2));
                case 28:
                    return (new ActionGetVariable(_arg_1, _arg_2));
                case 29:
                    return (new ActionSetVariable(_arg_1, _arg_2));
                case 32:
                    return (new ActionSetTarget2(_arg_1, _arg_2));
                case 33:
                    return (new ActionStringAdd(_arg_1, _arg_2));
                case 34:
                    return (new ActionGetProperty(_arg_1, _arg_2));
                case 35:
                    return (new ActionSetProperty(_arg_1, _arg_2));
                case 36:
                    return (new ActionCloneSprite(_arg_1, _arg_2));
                case 37:
                    return (new ActionRemoveSprite(_arg_1, _arg_2));
                case 38:
                    return (new ActionTrace(_arg_1, _arg_2));
                case 39:
                    return (new ActionStartDrag(_arg_1, _arg_2));
                case 40:
                    return (new ActionEndDrag(_arg_1, _arg_2));
                case 41:
                    return (new ActionStringLess(_arg_1, _arg_2));
                case 42:
                    return (new ActionThrow(_arg_1, _arg_2));
                case 43:
                    return (new ActionCastOp(_arg_1, _arg_2));
                case 44:
                    return (new ActionImplementsOp(_arg_1, _arg_2));
                case 48:
                    return (new ActionRandomNumber(_arg_1, _arg_2));
                case 49:
                    return (new ActionMBStringLength(_arg_1, _arg_2));
                case 50:
                    return (new ActionCharToAscii(_arg_1, _arg_2));
                case 51:
                    return (new ActionAsciiToChar(_arg_1, _arg_2));
                case 52:
                    return (new ActionGetTime(_arg_1, _arg_2));
                case 53:
                    return (new ActionMBStringExtract(_arg_1, _arg_2));
                case 54:
                    return (new ActionMBCharToAscii(_arg_1, _arg_2));
                case 55:
                    return (new ActionMBAsciiToChar(_arg_1, _arg_2));
                case 58:
                    return (new ActionDelete(_arg_1, _arg_2));
                case 59:
                    return (new ActionDelete2(_arg_1, _arg_2));
                case 60:
                    return (new ActionDefineLocal(_arg_1, _arg_2));
                case 61:
                    return (new ActionCallFunction(_arg_1, _arg_2));
                case 62:
                    return (new ActionReturn(_arg_1, _arg_2));
                case 63:
                    return (new ActionModulo(_arg_1, _arg_2));
                case 64:
                    return (new ActionNewObject(_arg_1, _arg_2));
                case 65:
                    return (new ActionDefineLocal2(_arg_1, _arg_2));
                case 66:
                    return (new ActionInitArray(_arg_1, _arg_2));
                case 67:
                    return (new ActionInitObject(_arg_1, _arg_2));
                case 68:
                    return (new ActionTypeOf(_arg_1, _arg_2));
                case 69:
                    return (new ActionTargetPath(_arg_1, _arg_2));
                case 70:
                    return (new ActionEnumerate(_arg_1, _arg_2));
                case 71:
                    return (new ActionAdd2(_arg_1, _arg_2));
                case 72:
                    return (new ActionLess2(_arg_1, _arg_2));
                case 73:
                    return (new ActionEquals2(_arg_1, _arg_2));
                case 74:
                    return (new ActionToNumber(_arg_1, _arg_2));
                case 75:
                    return (new ActionToString(_arg_1, _arg_2));
                case 76:
                    return (new ActionPushDuplicate(_arg_1, _arg_2));
                case 77:
                    return (new ActionStackSwap(_arg_1, _arg_2));
                case 78:
                    return (new ActionGetMember(_arg_1, _arg_2));
                case 79:
                    return (new ActionSetMember(_arg_1, _arg_2));
                case 80:
                    return (new ActionIncrement(_arg_1, _arg_2));
                case 81:
                    return (new ActionDecrement(_arg_1, _arg_2));
                case 82:
                    return (new ActionCallMethod(_arg_1, _arg_2));
                case 83:
                    return (new ActionNewMethod(_arg_1, _arg_2));
                case 84:
                    return (new ActionInstanceOf(_arg_1, _arg_2));
                case 85:
                    return (new ActionEnumerate2(_arg_1, _arg_2));
                case 96:
                    return (new ActionBitAnd(_arg_1, _arg_2));
                case 97:
                    return (new ActionBitOr(_arg_1, _arg_2));
                case 98:
                    return (new ActionBitXor(_arg_1, _arg_2));
                case 99:
                    return (new ActionBitLShift(_arg_1, _arg_2));
                case 100:
                    return (new ActionBitRShift(_arg_1, _arg_2));
                case 101:
                    return (new ActionBitURShift(_arg_1, _arg_2));
                case 102:
                    return (new ActionStrictEquals(_arg_1, _arg_2));
                case 103:
                    return (new ActionGreater(_arg_1, _arg_2));
                case 104:
                    return (new ActionStringGreater(_arg_1, _arg_2));
                case 105:
                    return (new ActionExtends(_arg_1, _arg_2));
                case 129:
                    return (new ActionGotoFrame(_arg_1, _arg_2));
                case 131:
                    return (new ActionGetURL(_arg_1, _arg_2));
                case 135:
                    return (new ActionStoreRegister(_arg_1, _arg_2));
                case 136:
                    return (new ActionConstantPool(_arg_1, _arg_2));
                case 138:
                    return (new ActionWaitForFrame(_arg_1, _arg_2));
                case 139:
                    return (new ActionSetTarget(_arg_1, _arg_2));
                case 140:
                    return (new ActionGotoLabel(_arg_1, _arg_2));
                case 141:
                    return (new ActionWaitForFrame2(_arg_1, _arg_2));
                case 142:
                    return (new ActionDefineFunction2(_arg_1, _arg_2));
                case 143:
                    return (new ActionTry(_arg_1, _arg_2));
                case 148:
                    return (new ActionWith(_arg_1, _arg_2));
                case 150:
                    return (new ActionPush(_arg_1, _arg_2));
                case 153:
                    return (new ActionJump(_arg_1, _arg_2));
                case 154:
                    return (new ActionGetURL2(_arg_1, _arg_2));
                case 155:
                    return (new ActionDefineFunction(_arg_1, _arg_2));
                case 157:
                    return (new ActionIf(_arg_1, _arg_2));
                case 158:
                    return (new ActionCall(_arg_1, _arg_2));
                case 159:
                    return (new ActionGotoFrame2(_arg_1, _arg_2));
                default:
                    return (new ActionUnknown(_arg_1, _arg_2));
            };
        }


    }
}

