//
//  LocationSelectionLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/09.
//

extension LocationSelectionViewController {
    
    func hierarchy(){
        self.view.addSubview(progressBar)
        self.view.addSubview(label)
        self.view.addSubview(searchBar1)
        self.view.addSubview(searchBar2)
        self.view.addSubview(searchBar3)
        self.view.addSubview(locationSearchBtn)
        self.view.addSubview(nextBtn)
    }
    
    func layout(){
                
        progressBar.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(4)
        }
        
        label.snp.makeConstraints{ make in
            make.top.equalTo(progressBar.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        
        searchBar1.snp.makeConstraints{ make in
            make.top.equalTo(label.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        searchBar2.snp.makeConstraints{ make in
            make.top.equalTo(searchBar1.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        searchBar3.snp.makeConstraints{ make in
            make.top.equalTo(searchBar2.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        locationSearchBtn.snp.makeConstraints{ make in
            make.top.equalTo(searchBar3.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        
        nextBtn.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(62)
        }

    }
}

