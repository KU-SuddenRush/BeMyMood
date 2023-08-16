# Be My Mood
### 발자국으로 채우는 무드 팔레트

![Logo](https://github.com/KU-SuddenRush/BeMyMood/assets/96233738/cff210dd-2863-4b43-b0b5-4f5b1851b175)


### ‘나의 취향’과 ‘나만의 것’을 중요시하는 MZ세대들을 위한 스팟 커스터마이징 서비스

좋아하는 무드에 따라 나에게 맞는 스팟을 큐레이팅해주고, 더 나아가 해당 스팟에서 경험한 것들로 무드보드를 꾸미고 공유하며 스팟을 커스터마이징 할 수 있습니다.

우리는 우리가 속해 있는 장소가 주는 분위기와 감성에 따라 달라지는 경험을 합니다. 비마이무드는 장소가 주는 감성에 주목하였고, 내가 좋아하는 공간에 가서 나에게 더 집중하고 내가 좋아하는 것들, 나에게 의미있는 것들로 하루하루를 채워나가길 바라는 우리들에게 특별한 경험을 제공하고자 합니다.

<br>

## 급발진 / 팀 소개
|이름|담당|
|--|--|
| [유경종](https://github.com/60jong) | 팀장, 기획, 서버 개발 |
| [정경은](https://github.com/ro-el-c) | 기획, 서버 개발 |
| [송채영](https://github.com/chaeyoung103) | 기획, iOS 개발 |
| [임윤섭](https://github.com/YoonSubLim) | 기획, iOS 개발 |
| 한고은 | 기획, 디자인 |

<br>
<br>

## 기능 목록
- 회원가입 / 로그인
- 선호 무드(분위기 / 색) & 선호 위치 선택
- 선호 데이터에 따른 스팟 추천
- 선호 외 스팟 필터링
- 스팟 리뷰
- 뱃지 획득
- 무드보드 작성

<br>
<br>

## 기능 소개
### 회원가입 / 로그인

<center>
  <img src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/e5a0ef2c-abc5-4f4e-9a7e-e096d8ceb50b" width='30%'/>
</center>

자체 회원가입 / 로그인을  Session으로 Member 상태 유지했습니다. 

<b>Hash Table</b> (Key : Session Id, Value : Member Id) 사용으로 빠른 접근이 가능합니다.

<br/>
<br/>

***

### 무드 및 선호 지역 선택

<table>
  <tr>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/9fe24126-e60d-4ed8-965d-793697e46b89" /></td>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/361afb67-8dbe-4548-a87d-526b10907f80" /></td>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/6f99f1f4-47b4-4cab-bfae-feab97a49b94"/></td>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/ee431bc8-3888-4a85-9bd0-992f12496c6f" /></td>
  <tr>
</table>

사용자는 회원가입시 무드(색상, 분위기)와 3개의 선호 지역을 선택한다.

이는 '나의 취향'에 초점을 맞춘 첫 걸음에 해당하며, 사용자가 앱을 사용함에 있어 기반이 된다.

<br/>
<br/>

***

### 스팟 필터링 (나의 무드 반영)

![image](https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/eda21318-93ee-4c7b-abaf-69573bcd7702)

'나의 취향'에 맞추어 스팟을 추천해줍니다.


#### 추천 알고리즘
스팟 추천 시에 내가 선택한 무드, 위치를 기반으로 추천 점수를 계산합니다. 이 점수를 계산해 높은 점수의 스팟부터 정렬합니다.

- 위치 match -> 1점
- 무드 match -> 무드 당 1점


<br/>
<br/>

***

### 스팟 필터링 

<img width="20%" src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/639c0efe-51f9-411d-8f2c-fcbad18851ec"/>

스팟 `카테고리`와 더불어, 선호 무드와 위치에 설정해놓지 않은 `무드`와 `위치`로도 스팟을 필터링해볼 수 있습니다.

<br/>
<br/>

***

### 스팟 기록하기

<img src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/e1602bbb-1ccb-41ac-99c8-0c17db0370f7" width="20%"/>

다녀온 스팟에 대해 기록을 담길 수 있습니다. 

내 기록을 공개로 남기게 되면 `리뷰`가 되고 스팟에 연관된 무드들을 얻을 수 있습니다.

<br/>
<br/>

***

### 뱃지 획득

<table>
  <tr>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/74dd0440-a339-4569-94cb-6bac62056365" width="200"/></td>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/b28ff017-247c-4f05-a723-d8b3d0894332" width="200"/></td>
  <tr>
</table>

`리뷰`를 작성함으로써 얻은 무드마다 특정 조건을 충족하면, 무드에 대한 뱃지를 얻게 됩니다. 

선호 무드에 등록하지 않았어도 얻은 무드 뱃지를 보며 몰랐던 나의 취향을 알아가요.

<br/>
<br/>

***

### 무드보드

'나만의 것'을 채워나가는 서비스입니다.

내가 기록한 내용에 포함된 이미지, 획득한 스팟 시그니처 이미지, 앱 내에서 제공하는 스티커, 직접 입력한 텍스트로 자신만의 무드보드를 꾸밀 수 있습니다.

<table>
  <tr>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/96233738/1e7adcc7-c557-4ae3-b3ec-2a828c79ae3f" /></td>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/96233738/8c6be052-7706-4fe4-9060-079a78712e0e"/></td>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/96233738/4bfef124-81fb-4b64-9c50-969732c501aa" /></td>
    <td><img src="https://github.com/KU-SuddenRush/BeMyMood/assets/96233738/52de5db2-4369-42d8-a457-224cd2b2ffcd" /></td>
  <tr>
</table>

<br/>
<br/>

#### 유사한 서비스와 차별점
무드보드 서비스는 여러 아이템을 이용해 한 화면을 꾸미고 저장할 수 있다는 점에서 인스타그램의 스토리 기능과 유사합니다.

하지만, Be My Mood의 무드보드 서비스는 오로지 **나의 취향**으로 쌓아온 이미지 데이터를 이용한다는 점에서 분명한 차이를 보입니다.

나의 무드를 기반으로 추천 받은 장소를 방문하고, 나만의 사진과 내용을 기록하며, 이 이미지를 이용하여 나만의 여러 가지 무드보드를 채워나가는 과정을 통해서

사용자는 다양한 나를 알아가고, 완성해 나갈 수 있습니다.


<br/>
<br/>

#### 커뮤니티 (추후 개발 방향성)
MZ 세대의 또 다른 특징으로는 '**활발한 소통**'이 있습니다.

사람들은 SNS를 통하여 다양한 주제에 대하여 자신의 의견을 펼치기도 하고 자신과 유사한 사람들과 뭉치는 것을 즐깁니다.

Be My Mood의 서비스 전반이 사용자의 무드(취향)를 기반으로 제공되므로, 위 특징을 반영하기 최적의 서비스입니다.

따라서, 커뮤니티 서비스를 추후 개발 목표로 두었습니다. 커뮤니티 서비스가 활성화되면, 사용자는 자신과 유사한 취향을 가진 사람의 무드보드를 구경할 수 있으며 좋아요와 댓글 기능을 통하여 활발하게 소통을 할 수 있을 것입니다.

<br/>
<br/>

## 시스템 아키텍처

### 서비스 아키텍처
<img width="500" alt="비마이무드_시스템_아키텍처" src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/af41312d-b4d6-4004-a526-07bba27a2e20">

## ER 다이어그램
<img width="500" src="https://github.com/KU-SuddenRush/BeMyMood/assets/93924890/a260ada5-3231-48e6-abc3-c78b15d2dc41"/>
