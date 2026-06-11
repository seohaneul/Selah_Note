import os
import json
import re

def process_bible_txt(input_path, output_path):
    """
    Reads a raw text file containing bible verses and outputs a JSON file
    formatted for the Selah Note app.
    
    Expected format per line:
    "창1:1 태초에 하나님이 천지를 창조하시니라"
    -> split by first space: key="창1:1", value="태초에 하나님이 천지를 창조하시니라"
    """
    print(f"🔄 처리 중: {input_path} ...")
    
    data = {}
    lines = []
    
    # 텍스트 파일 인코딩(utf-8 또는 cp949/euc-kr) 자동 처리
    try:
        with open(input_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
    except UnicodeDecodeError:
        with open(input_path, 'r', encoding='cp949') as f:
            lines = f.readlines()
            
    for line in lines:
        line = line.strip()
        if not line:
            continue
            
        # 첫 번째 공백을 기준으로 키(예: 창1:1)와 본문을 나눕니다.
        parts = line.split(" ", 1)
        if len(parts) == 2:
            key = parts[0].strip()
            verse_text = parts[1].strip()
            data[key] = verse_text
        else:
            print(f"⚠️ 경고: 알 수 없는 형식의 줄을 건너뜁니다 -> {line}")
                
    # JSON 파일로 저장
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        
    print(f"✅ 변환 완료: {output_path} (총 {len(data)}구절)")

def main():
    # 현재 스크립트 위치 기준으로 경로 설정
    script_dir = os.path.dirname(os.path.abspath(__file__))
    input_dir = os.path.join(script_dir, "raw_data")
    output_dir = os.path.join(script_dir, "output")
    
    # 폴더가 없으면 생성
    os.makedirs(input_dir, exist_ok=True)
    os.makedirs(output_dir, exist_ok=True)
    
    txt_files = [f for f in os.listdir(input_dir) if f.endswith('.txt')]
    
    if not txt_files:
        print("❌ 변환할 텍스트 파일이 없습니다.")
        print(f"'{input_dir}' 폴더 안에 '.txt' 파일을 넣어주세요.")
        return
        
    for txt_file in txt_files:
        base_name = os.path.splitext(txt_file)[0]
        input_path = os.path.join(input_dir, txt_file)
        # 생성될 JSON 파일 이름 (예: bible_개역개정.json)
        output_path = os.path.join(output_dir, f"bible_{base_name}.json")
        
        process_bible_txt(input_path, output_path)
        
    print("\n🎉 모든 성경 데이터 변환이 완료되었습니다!")
    print("생성된 JSON 파일을 앱의 'assets/' 폴더에 넣고 pubspec.yaml 및 코드에 연결하여 사용하세요.")

if __name__ == "__main__":
    main()
