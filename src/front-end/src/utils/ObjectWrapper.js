export const baseInfoWrapper = function (baseInfo) {
	return {
		title: baseInfo[0],
		isFinished: baseInfo[1],
		desc: baseInfo[2],
		sponsor: baseInfo[3],
		ddl: (baseInfo[4].c)[0],
		cost: (baseInfo[5].c)[0],
		bonus: (baseInfo[6].c)[0]
	};
}

export const allInfoWrapper = function (allInfo) {
	// (title, isFinished, desc, sponsor, ddl, cost, bonus, content, answer, winner);
	return {
		title: allInfo[0],
		isFinished: allInfo[1],
		desc: allInfo[2],
		sponsor: allInfo[3],
		ddl: (allInfo[4].c)[0],
		cost: (allInfo[5].c)[0],
		bonus: (allInfo[6].c)[0],
		content: allInfo[7],
		answer: allInfo[8],
		winner: allInfo[9]
	}
}