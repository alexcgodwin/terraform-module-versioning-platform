"""Static module interface contracts, fail-closed on accidental v1.1 breakage."""
from __future__ import annotations
import json
import re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

def is_compatible(old: dict, new: dict) -> tuple[bool,list[str]]:
    issues=[]
    for name in old['inputs']:
        if name not in new['inputs']:
            issues.append('removed_input:'+name)
        elif old['inputs'][name]!=new['inputs'][name]:
            issues.append('modified_input_contract:'+name)
    for name,requirement in new['inputs'].items():
        if name not in old['inputs'] and requirement=='required':
            issues.append('new_required_input:'+name)
    for name in old['outputs']:
        if name not in new['outputs']:
            issues.append('removed_output:'+name)
    return not issues,issues

def main() -> int:
    versions=json.loads((ROOT/'contracts/modules.json').read_text())
    ok,issues=is_compatible(versions['v1.0.0'],versions['v1.1.0'])
    major_ok,major_issues=is_compatible(versions['v1.1.0'],versions['v2.0.0'])
    assert ok,issues
    assert not major_ok and major_issues,'Major release must capture interface break'
    paths={'v1.0.0':'v1','v1.1.0':'v1_1','v2.0.0':'v2'}
    for tag,dirname in paths.items():
        config=(ROOT/'modules'/dirname/'main.tf').read_text()
        names=set(re.findall(r'variable\s+"([^"]+)"',config))
        outputs=set(re.findall(r'output\s+"([^"]+)"',config))
        assert names==set(versions[tag]['inputs']), f'{tag}: variable catalog drift'
        assert outputs==set(versions[tag]['outputs']), f'{tag}: output catalog drift'
    print('v1 to v1.1 compatible; v2 breaking change documented; catalogs match HCL')
    return 0

if __name__=='__main__':raise SystemExit(main())
